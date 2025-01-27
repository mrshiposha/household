options: {
	system = "x86_64-linux";

	nixos.imports = [
		./hardware-configuration.nix
		./users

		(
			{ config, household, pkgs, ... }:
			{
				system.stateVersion = "24.11";
				networking.hostName = "hearthstone";

				boot.initrd.kernelModules = [ "amdgpu" ];
				systemd.tmpfiles.rules = [
					"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
				];

				networking.interfaces.enp3s0 = {
					ipv6.addresses = options.ip.addr.v6;
					ipv4.addresses = options.ip.addr.v4;
					useDHCP = true;
				};

				gui = {
					enable = true;
					games.enable = true;
					greeter.seat0.theme = household.greeterThemeFromUserTheme
						config.home-manager.users.mrshiposha;
				};
				multiseat = {
					enable = true;

					driPrimePci = "0000:03:00.0";

					extraSeats.seat-art.devices = [
						{
							subsystem = "drm";
							pci = "0000:6c:00.0";
						}

						{
							subsystem = "pci";
							pci = "0000:68:00.0";
						}
					];
				};
				security.poly = {
					enable = true;
					services = [ "greetd" ];
					instances = [{
						mount = "/tmp";
						source = "/poly/tmp";
						type = "tmpfs";
					}];
				};

				container-mgmt.enable = true;

				time.timeZone = "Europe/Belgrade";
			}
		)
	];
	# nixos.secrets = {
	# 	dev-email.owner = "mrshiposha";
	# };
}
