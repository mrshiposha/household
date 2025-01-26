{ config, lib, pkgs, ... }:
with lib;
{
	options.crypto.enable = mkEnableOption "crypto utilities";

	config = mkIf config.crypto.enable {
		services.gpg-agent = {
			enable = true;
			pinentryPackage = pkgs.pinentry-rofi;
		};
		programs = {
			gpg.enable = true;
			password-store.enable = true;
		};

		firefox.passff.enable = mkDefault true;
	};
}
