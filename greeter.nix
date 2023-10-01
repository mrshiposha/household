{ config, pkgs, lib, ... }: with lib;
let
  cfg = config.greeter;
  greetdPackage = (pkgs.callPackage ./common/packages/greetd.nix {});
  vt = "1";
  tty = "tty${vt}";

  swayConfig = pkgs.writeText "greetd-sway-config" ''
    input * {
        xkb_layout "us,ru"
        xkb_options "altwin:swap_alt_win,grp:win_space_toggle"
    }

    exec systemctl --user import-environment SWAYSOCK WAYLAND_DISPLAY

    exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"
  '';

  greetdSettings = seat: {
    terminal.vt = if seat == "seat0" then vt else "none";
    general.seat = seat;
    default_session = {
      user = "${seat}-greeter";
      command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
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
          unitConfig = {
          Wants = [
            "systemd-user-sessions.service"
          ];
          After = [
            "systemd-user-sessions.service"
            "plymouth-quit-wait.service"
            "getty@${tty}.service"
          ];
          Conflicts = [
            "getty@${tty}.service"
          ];
        };

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

        wantedBy = [ "graphical.target" ];    
        };
      }) seats
    ) // {
      "autovt@${tty}".enable = false;
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
          theme_name = "Orchis-Green-Dark";
          cursor_theme_name = "Quintom_Ink";
          icon_theme_name = "Papirus-Dark";
        };

        commands = {
          reboot = ["systemctl" "reboot"];
          poweroff = ["systemctl" "poweroff"];
        };
      };
    };

    systemd.tmpfiles.rules = builtins.concatMap (seat: [
      "d /var/log/regreet 0755 ${seat}-greeter greeter - -"
      "d /var/cache/regreet 0755 ${seat}-greeter greeter - -"
    ]) seats;
  };
}
