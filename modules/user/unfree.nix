{ lib, ... }:
with lib;
{
	options = {
		unfree.list = with types; mkOption {
			type = listOf package;
			default = [];
		};
	};
}
