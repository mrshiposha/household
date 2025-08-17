{ config, lib, pkgs, ... }:
with lib;
with types; {
  options.razer = {
    enable = mkOption {
      type = bool;
      default = config.gui.enable;
    };
  };

  config = mkIf config.razer.enable {
    hardware.openrazer.enable = true;

    environment.systemPackages = [ pkgs.polychromatic ];
  };
}
