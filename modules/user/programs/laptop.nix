{ nixosConfig, pkgs, lib, ... }:
with lib;
{
	home.packages = mkIf nixosConfig.laptop.enable (with pkgs; [
		brightnessctl
	]);
}
