{ config, lib, pkgs, ... }:
with lib;
with lib.types;
let
	extensionUrl =
		name: version: "https://addons.mozilla.org/firefox/downloads/latest/${name}/${version}.xpi";
in
{
	options.firefox = {
		enable = mkEnableOption "firefox";
		addons = mkOption {
			type = listOf str;
			default = [];
		};
		passff.enable = mkEnableOption "pasff";
		defaultPdfApp = mkOption {
			type = bool;
			default = false;
		};
	};

	config = mkIf config.firefox.enable {
		programs.firefox = {
			enable = true;
			package = with pkgs; mkIf config.firefox.passff.enable (firefox.override {
				nativeMessagingHosts = [passff-host];
			});
			policies = {
				DisableTelemetry = true;

				Preferences = {
					xpinstall.signatures.required = false;
				};

				Extensions = {
					Install = builtins.map (addon: extensionUrl addon "latest") config.firefox.addons
						++ ( if config.firefox.passff.enable then ["passff"] else [] );
				};
			};
		};

		xdg.mimeApps.defaultApplications."application/pdf" = mkIf
			config.firefox.defaultPdfApp
			[ "firefox.desktop" ];
	};
}
