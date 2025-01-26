{ config, lib, household, ... }:
with lib;
with lib.types;
let
	cfg = config.unfree;
in
{
	options = {
		unfree.list = mkOption {
			type = listOf package;
			default = [];
		};
	};

	config =
		let
			usersFullUnfreeList = builtins.concatMap (unfree: unfree.list) (
				household.userModulesByName config "unfree"
			);
			fullUnfreeList = cfg.list ++ usersFullUnfreeList;
		in
		{
			nixpkgs.config.allowUnfreePredicate =
				pkg:
				builtins.elem (lib.getName pkg) (builtins.map (listedPkg: (lib.getName listedPkg)) fullUnfreeList);
		};
}
