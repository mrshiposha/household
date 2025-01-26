{ config, pkgs, lib, ... }:
with lib;
{
	options.rofi.enable = mkEnableOption "rofi";

	config = mkIf config.rofi.enable {
		programs.rofi = {
			enable = true;
			package = pkgs.rofi-wayland;
			terminal = "wezterm";
			theme = ./theme.rasi;
			pass.enable = config.crypto.enable;
			plugins = with pkgs; [
				# pkgs.rofi-calc -- broken, see https://github.com/NixOS/nixpkgs/issues/298539
				(rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
				rofi-power-menu
			];
			# "calc" -- broken
			# extraConfig.modes = "drun,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu,calc";
			extraConfig.modes = "drun,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
		};
	};
}
