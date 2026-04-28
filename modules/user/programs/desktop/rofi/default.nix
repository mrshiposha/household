{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.rofi.enable = mkEnableOption "rofi";

  config = mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      terminal = "wezterm";
      theme = ./theme.rasi;
      pass.enable = config.crypto.enable;
      plugins = with pkgs; [
        rofi-calc
        rofi-power-menu
      ];
      extraConfig.modes = "drun,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
    };
  };
}
