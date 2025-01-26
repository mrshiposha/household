{ household, pkgs, ... }:
let uid = 1001; in {
	users.users.wally = {
		isNormalUser = true;
		inherit uid;
		description = "Valentina Shiposha";
		extraGroups = [ "openrazer" ];
	};
	gui.games.mountSharedLibraryFor = [
		{
			ownerName = "wally";
			ownerId = uid;
			groupId = household.usersGid;
		}
	];

	home-manager.users.wally = {
		imports = [ household.modules.user ];

		preset.wally.enable = true;

		obs.enable = true;

		theming.gui.wallpapers = {
			active = household.image /2560x1440/matthew-smith-nature.png;
			screensaver = household.image /2560x1440/mountain-range.jpg;
		};

		home.packages = with pkgs; [
			teamspeak5_client
		];

		unfree.list = with pkgs; [
			teamspeak5_client
		];
	};
}
