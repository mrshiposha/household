{ config, pkgs, lib, ... }:
with lib;
with types;
{
  options.obs.enable = mkEnableOption "OBS Studio";

  config.programs.obs-studio = {
    enable = config.obs.enable;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-vaapi
    ];
  };
}
