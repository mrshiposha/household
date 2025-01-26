{ config, lib, ... }:
with lib;
{
	options.laptop.enable = mkEnableOption "laptop system";

	config = mkIf config.laptop.enable {
		net.wireless.enable = mkDefault true;

		services.thermald.enable = config.intel.enable;
		services.tlp = {
			settings = {
				CPU_BOOST_ON_AC = 1;
				CPU_BOOST_ON_BAT = 0;
				CPU_SCALING_GOVERNOR_ON_AC = "performance";
				CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
			};
		};
	};
}
