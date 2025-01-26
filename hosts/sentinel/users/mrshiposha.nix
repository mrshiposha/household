{ household, ... }:
{
	users.users.mrshiposha = {
		isNormalUser = true;
		uid = 1000;
		description = "Daniel Shiposha";
		extraGroups = [ "wheel" ];
		openssh.authorizedKeys.keys = [
			"ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHmZnSmZDnHFygrM92wZNYscEMYlz6am9/7mefjS9ovoSOiNiw0dypN35yQhUS2S3LD5QGEV+DSba4Z8XCE9bCESgH91dg9siOdNvROLaT2/ZPNHlHWoic78WyShc6QN14rzle4KxObsw90iEdS1Q0RGASf6/xuWPa65pS6oKOVfPNeLw== mrshiposha@satellite"
		];
	};

	home-manager.users.mrshiposha = {
		imports = [ household.modules.user ];
		preset.mrshiposha.enable = true;
	};
}
