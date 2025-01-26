{ nixosConfig, config, lib, ... }:
with lib;
{
	imports = [
		./compositor
		./waybar
		./mako.nix
		./rofi
	];

	options.desktop.enable = mkEnableOption "desktop";

	config = {
		compositor.enable = mkDefault config.desktop.enable;
		waybar.enable = mkDefault (
			if nixosConfig.laptop.enable
			then config.desktop.enable
			else false
		);
		mako.enable = mkDefault config.desktop.enable;
		rofi.enable = mkDefault config.desktop.enable;
	};
}
