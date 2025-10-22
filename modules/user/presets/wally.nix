{ config, lib, pkgs, unstablePkgs, pkgs20250902, household, ... }:
with lib;
let cfg = config.preset.wally;
in {
  options.preset.wally = { enable = mkEnableOption "wally user"; };

  config = mkIf cfg.enable {
    preset.regularUser.enable = mkDefault true;

    firefox.addons = [ ];

    home.packages = with pkgs; [
      pureref
      unstablePkgs.blender-hip
      blockbench
      pkgs20250902.krita
    ];

    unfree.list = with pkgs; [ pureref ];

    xdg.desktopEntries.pureref = {
      name = "PureRef";
      icon = household.image /logo/pureref.png;
      exec = "pureref";
    };
  };
}
