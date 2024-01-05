{ config, pkgs, lib, ... }: with lib;
let
  cfg = config.greeter;
  greetdPackage = (pkgs.callPackage ./common/packages/greetd.nix {});
  regreetPackage = (pkgs.callPackage ./common/packages/regreet.nix {});
  
  seat0-vt = "1";
  seat0-tty = "tty${seat0-vt}";
  gettyService = seat: lib.lists.optional (seat == "seat0") "getty@${seat0-tty}.service";
  
  seatLogDir = seat: "/var/log/regreet/${seat}";
  seatCacheDir = seat: "/var/cache/regreet/${seat}";

  swayConfig = pkgs.writeText "greetd-sway-config" ''
    input * {
        xkb_layout "us"
    }

    exec systemctl --user set-environment XDG_CURRENT_DESKTOP=sway
    exec systemctl --user import-environment SWAYSOCK WAYLAND_DISPLAY

    exec "${regreetPackage}/bin/regreet; swaymsg exit"
  '';

  greetdSettings = seat: {
    terminal.vt = if seat == "seat0" then seat0-vt else "none";
    general.seat = seat;
    default_session = {
      user = "${seat}-greeter";
      command = "${pkgs.sway}/bin/sway --config ${swayConfig} > ${seatLogDir seat}/sway.log 2>&1";
    };
  };

  settingsFormat = pkgs.formats.toml {};
in {
  options.greeter = {
    enable = mkEnableOption null;

    backgroundImage = mkOption {
      type = types.str;
    };

    extraSeats = mkOption {
      default = [];
      type = types.listOf types.str;
    };
  };

  config = let seats = ["seat0"] ++ cfg.extraSeats; in mkIf cfg.enable {
    systemd.defaultUnit = "graphical.target";

    security.pam.services.greetd = {
      allowNullPassword = false;
      startSession = true;
    };

    systemd.services = builtins.listToAttrs (
      builtins.map (seat: {
        name = "${seat}-greeter";
        value = {
          description = "${seat}-greeter";
          wants = ["multi-user.target"];
          wantedBy = [ "graphical.target" ];
          after = [
            "multi-user.target"
            "plymouth-quit-wait.service"
          ];
          conflicts = gettyService seat;

          serviceConfig = {
            ExecStart = "${greetdPackage}/bin/greetd --config ${settingsFormat.generate "${seat}-greetd.toml" (greetdSettings seat)}";

            Restart = mkIf (!((greetdSettings seat) ? initial_session)) "always";

            # Defaults from greetd upstream configuration
            IgnoreSIGPIPE = false;
            SendSIGHUP = true;
            TimeoutStopSec = "30s";
            KeyringMode = "shared";

            Type = "idle";
          };

          # Don't kill a user session when using nixos-rebuild
          restartIfChanged = false;  
        };
      }) seats
    ) // {
      "autovt@${seat0-tty}".enable = false;
    };

    users.users = builtins.listToAttrs (
      builtins.map (seat: {
        name = "${seat}-greeter";
        value = {
          isSystemUser = true;
          group = "greeter";
        };
      }) seats
    );

    users.groups.greeter = {};

    environment.etc = {
      "greetd/environments".text = ''
        sway
      '';

      "greetd/regreet.css".text = "";

      "greetd/regreet.toml".source = settingsFormat.generate "regreet.toml" {
        background = {
          path = cfg.backgroundImage;
          fit = "Contain";
        };

        GTK = {
          application_prefer_dark_theme = true;
          theme_name = "Nordic";
          cursor_theme_name = "Quintom_Ink";
          icon_theme_name = "Zafiro-icons-Dark";
        };

        commands = {
          reboot = ["systemctl" "reboot"];
          poweroff = ["systemctl" "poweroff"];
        };
      };
    };

    systemd.tmpfiles.rules = builtins.concatMap (seat: [
      "d ${seatLogDir seat} 0775 ${seat}-greeter greeter - -"
      "d ${seatCacheDir seat} 0775 ${seat}-greeter greeter - -"
    ]) seats;
  };
}
