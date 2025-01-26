{ lib, ... }:
with lib;
{
	options.intel.enable = mkEnableOption "intel-related stuff";
}
