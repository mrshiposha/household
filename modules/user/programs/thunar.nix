{ config, pkgs, lib, ...  }:
with lib;
{
  options.thunar = {
    enable = mkEnableOption "thunar file manager";
  };

  config = mkIf config.thunar.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
      xfconf.enable = true;
    };
  };
}
