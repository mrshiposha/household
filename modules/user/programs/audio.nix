{ nixosConfig, pkgs, lib, ... }:
with lib;
{
	home.packages = mkIf nixosConfig.audio.enable (with pkgs; [
		pavucontrol
		pamixer
	]);
}
