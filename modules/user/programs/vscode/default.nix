{ config, pkgs, lib, ... }:
with lib;
let cfg = import ./cfg.nix; in
{
	options.vscode.enable = mkEnableOption "vscode";

	config = mkIf config.vscode.enable {
		programs.vscode = {
			enable = true;
			package = pkgs.vscodium;
			mutableExtensionsDir = false;
			extensions = import ./extensions.nix pkgs;
			userSettings = cfg.settings;
			keybindings = cfg.keybindings;
		};

		home.packages = with pkgs; [
			nil
			nixpkgs-fmt
			typst
			typstyle
			tinymist
		];
	};
}
