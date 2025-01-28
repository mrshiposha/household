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

				virtualisation.libvirtd.enable = true;
				boot.extraModprobeConfig = ''
					options kvm_amd nested=1
					options kvm ignore_msrs=1 report_ignored_msrs=0
				'';

				time.timeZone = "Europe/Belgrade";

				swapDevices = [
					{
						device = "/swapfile";
						size = 64 * 1024; # 64 GiB
					}
				];
			}
		)
	];
	# nixos.secrets = {
	# 	dev-email.owner = "mrshiposha";
	# };
}
