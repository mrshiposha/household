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

    seats = mkOption {
      default = ["seat0"];
      type = types.listOf types.str;
    };
  };

  config = mkIf cfg.enable {
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
      }) cfg.seats
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
      }) cfg.seats
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
      "d /var/log/regreet 0755 greeter ${seat}-greeter - -"
      "d /var/cache/regreet 0755 greeter ${seat}-greeter - -"
    ]) cfg.seats;
  };
}
