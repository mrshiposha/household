{ household, ... }:
let uid = 1000; in {
	users.users.mrshiposha = {
		isNormalUser = true;
		inherit uid;
		description = "Daniel Shiposha";
		extraGroups = [
			"wheel"
			"libvirtd"
			"podman"
			"openrazer"
		];
		openssh.authorizedKeys.keys = [
			"ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHmZnSmZDnHFygrM92wZNYscEMYlz6am9/7mefjS9ovoSOiNiw0dypN35yQhUS2S3LD5QGEV+DSba4Z8XCE9bCESgH91dg9siOdNvROLaT2/ZPNHlHWoic78WyShc6QN14rzle4KxObsw90iEdS1Q0RGASf6/xuWPa65pS6oKOVfPNeLw== mrshiposha@satellite"
		];
	};
	gui.games.mountSharedLibraryFor = [
		{
			ownerName = "mrshiposha";
			ownerId = uid;
			groupId = household.usersGid;
		}
	];

	home-manager.users.mrshiposha = {
		imports = [ household.modules.user ];

		theming.gui.wallpapers = {
			active = household.image /2560x1440/matthew-smith-nature.png;
			screensaver = household.image /2560x1440/mountain-range.jpg;
		};

		preset.mrshiposha = {
			enable = true;
			# devEmail = true; # FIXME
		};
	};
}
