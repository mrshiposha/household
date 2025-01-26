{
	household = rec {
		modules.system = ../modules/system;
		modules.user = import ../modules/user {
			inherit image;
		};
		image = path: ../images + path;

		usersGid = 100;

		eachSystemConfig = { nixpkgs, fleet, ... }: system:
			let pkgs = import nixpkgs { inherit system; }; in {
				devShells.default = pkgs.mkShell {
				packages = [ fleet.packages.${system}.default ];
			};
		};

		userModulesByName =
			config: moduleName:
			let
				users = builtins.attrValues config.home-manager.users;
			in
			builtins.map (user: user.${moduleName}) (builtins.filter (user: builtins.hasAttr "${moduleName}" user) users);

		greeterThemeFromUserTheme =
			user:
			let
				theming = user.theming.gui;
			in
			{
				wallpaper = theming.wallpapers.screensaver;
				style = theming.style;
				cursors = theming.cursors;
				icons = theming.icons;
			} // (if theming.fonts.defaults.enable then {
				font.name = builtins.head theming.fonts.defaults.serif;
			} else {});
	};
}
