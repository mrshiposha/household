{ config, lib, pkgs, unstablePkgs, household, ... }:
with lib;
let
	cfg = config.preset.wally;
in
{
	options.preset.wally = {
		enable = mkEnableOption "wally user";
	};

	config = mkIf cfg.enable {
		preset.regularUser.enable = mkDefault true;

		firefox.addons = [ "grammarly-1" ];

		home.packages = with pkgs; [
			pureref
			unstablePkgs.blender-hip
			blockbench
		];

		unfree.list = with pkgs; [
			pureref
		];

    xdg.desktopEntries.pureref = {
			name = "PureRef";
			icon = household.image /logo/pureref.png;
			exec = "pureref";
    };
	};
}
