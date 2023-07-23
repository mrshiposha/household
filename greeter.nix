{ background-image }:
{ config, lib, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    input * {
        xkb_layout "us,ru"
        xkb_options "altwin:swap_alt_win,grp:win_space_toggle"
    }

    exec dbus-sway-environment
    exec configure-gtk

    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s /etc/greetd/gtkgreet.css; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
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

  environment.etc."greetd/gtkgreet.css".text = ''
    window {
      background-image: url("file:///${background-image}");
      background-size: cover;
      background-position: center;
    }

    window label {
      color: #FFFFFF;
    }

    entry {
      color: #FFFFFF;
      border-color: #4CAF50;
      background-color: rgba(50, 50, 50, 0.5);
    }
  '';
}
