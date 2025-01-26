{ config, household, ... }:
let
	usersFonts = builtins.concatMap
		(
			theming:
			theming.gui.fonts.packages
			++ (if theming.gui.fonts.defaults.enable then theming.gui.fonts.defaults.packages else [ ])
		)
		(household.userModulesByName config "theming");
in
{
	fonts = {
		packages = usersFonts;
		fontDir.enable = true;
	};
}
