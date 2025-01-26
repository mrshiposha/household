{ config, lib, ... }:
with lib;
{
	options.lazygit.enable = mkEnableOption "lazygit";

	config.programs.lazygit = {
		enable = config.lazygit.enable;
	};
}
