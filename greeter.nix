{ background-image }:
{ config, lib, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    input * {
        xkb_layout "us,ru"
        xkb_options "altwin:swap_alt_win,grp:win_space_toggle"
    }

    exec systemctl --user import-environment SWAYSOCK WAYLAND_DISPLAY

    exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
  '';

  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = background-image;
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
}
