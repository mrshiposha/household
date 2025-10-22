{ config, pkgs, lib, ... }:
with lib;
let
  hyprland = config.wayland.windowManager.hyprland;

  gapsout = if hyprland.enable then hyprland.settings.general.gaps_out else 4;
in {
  options.waybar.enable = mkEnableOption "waybar";

  config = mkIf config.waybar.enable {
    theming.gui.fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.symbols-only
    ];
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings.main = rec {
        layer = "top";
        position = "bottom";

        margin-bottom = gapsout;
        margin-left = gapsout;
        margin-right = gapsout;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "backlight"
          "pulseaudio"
          "network"
          "bluetooth"
          "battery"
          "group/stats"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          format = "{windows}";
          persistent-workspaces."*" = 4;
          "window-rewrite-default" = "<sub></sub>";
          window-rewrite = {
            "class<rofi>" = "";
            "class<alacritty>" = "";
            "class<org.wezfurlong.wezterm.*>" = "";
            "class<org.wezfurlong.wezterm.*> title<btop>" = "";
            "class<org.pwmt.zathura>" = "";
            "class<Zathura>" = "";
            "class<org.wezfurlong.wezterm.*> title<Yazi.*>" = "";
            "class<thunar>" = "";
            "class<org.gnome.FileRoller>" = "";
            "class<com.interversehq.qView>" = "";
            "class<PureRef>" = "Ⓟ";
            "class<org.wezfurlong.wezterm.*> title<(\\[\\d/\\d\\] )?hx>" = "";
            "class<io.gitlab.adhami3310.Converter>" = "";
            "class<com.belmoussaoui.Decoder>" = "";
            "class<VSCodium>" = "󰨞";
            "class<Codium>" = "󰨞";
            "class<neovide>" = "";
            "class<firefox>" = "";
            "class<firefox> title<.*youtube.*>" = "";
            "class<firefox> title<.*Meet -.*>" = "<sub></sub>";
            "class<org.telegram.desktop>" = "";
            "class<slack>" = "";
            "class<discord>" = "";
            "class<Mattermost>" = "";
            "class<Element>" = "";
            "class<ghidra-Ghidra>" = "";
            "class<steam>" = "";
            "class<Logseq>" = "";
            "class<usbimager>" = "";

            "class<pavucontrol>" = "<sub></sub>";
            "class<nm-connection-editor>" = "<sub></sub>";
            "class<.blueman-manager-wrapped>" = "<sub></sub>";

            "class<firefox> title<.*Gmail.*>" = "<sub></sub>";
            "class<thunderbird>" = "";

            "class<qalculate-gtk>" = "";
          };
        };

        clock.format = "{:%H:%M} ";

        backlight = {
          format = "{percent}% ";
          reverse-scrolling = true;
          scroll-step = 0.1;
        };

        pulseaudio = {
          format = "{volume}% {icon} / {format_source}";
          format-icons = [ "" "" "" ];
          format-muted = " / {format_source}";
          format-source = "";
          format-source-muted = "";
          tooltip-format = "Sound Volume / Mic Status";
          on-click = "pavucontrol";
          reverse-scrolling = true;
          scroll-step = 0.1;
        };

        bluetooth = {
          format = "";

          tooltip-format = "Bluetooth {status}";
          tooltip-format-connected = "{device_alias}";
          tooltip-format-connected-battery =
            "{device_alias}<sub> {device_battery_percentage}%</sub>";

          # See https://github.com/Alexays/Waybar/issues/1850#issuecomment-1573304549
          on-click = "sleep 0.1 && ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
        };

        network = {
          interface = "wlan0";
          format-wifi = "";
          format-linked = "";
          format-disconnected = "";

          tooltip-format-wifi =
            "	{essid}\n	IP: {ipaddr}\n	Strength: {signalStrength}%\n";
          tooltip-format-linked = "connecting to {essid}";
          tooltip-format-disconnected = "WiFi disconnected";

          on-click = builtins.toString ./launch-wifi-menu.sh;
        };

        "group/stats" = {
          orientation = "inherit";
          modules = [ "cpu" "disk" "memory" ];

          drawer = { transition-duration = 500; };
        };

        "custom/power" = {
          format = "";
          exec = ''echo '{ "tooltip": "Power Menu" }' '';
          return-type = "json";

          # See https://github.com/Alexays/Waybar/issues/1850#issuecomment-1573304549
          on-click = "sleep 0.1 && rofi -show power-menu";
          tooltip-format = "Power Menu";
        };

        cpu = {
          format = "{usage}% ";
          on-click = "wezterm -e btop -p 2";
        };
        memory = {
          format = "{percentage}% RAM";
          on-click = cpu.on-click;
        };
        disk.format = "{percentage_used}% ";

        battery = {
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% {icon} ";
          format-icons = [ "" "" "" "" "" ];
          states = {
            warning = 30;
            critical = 15;
          };
        };
      };

      style = builtins.readFile ./style.css;
    };
  };
}
