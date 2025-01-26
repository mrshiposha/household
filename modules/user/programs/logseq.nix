{ config, pkgs, lib, ... }:
with lib;
{
	options.logseq.enable = mkEnableOption "logseq";
	config = mkIf config.logseq.enable {
		home.packages = [ pkgs.logseq ];
	};
}
