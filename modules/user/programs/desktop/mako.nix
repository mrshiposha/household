{ config, pkgs, lib, ... }:
with lib;
let
  hyprland = config.wayland.windowManager.hyprland;

  gapsout = if hyprland.enable then hyprland.settings.general.gaps_out else 4;
in {
  options.mako.enable = mkEnableOption "mako";

  config = mkIf config.mako.enable {
    home.packages = [ pkgs.libnotify ];

    services.mako = {
      enable = true;

      settings = {
        max-visible = -1;
        layer = "overlay";
        font = "monospace 12";
        background-color = "#4c566a9d";
        border-color = "#4c566a9d";
        text-color = "#D8DEE9";
        border-radius = 15;
        max-icon-size = 48;
        default-timeout = 2500;
        anchor = "bottom-right";
        margin = builtins.toString (gapsout + 20);
        width = 426;
        outer-margin = 32;
      };
    };
  };
}
