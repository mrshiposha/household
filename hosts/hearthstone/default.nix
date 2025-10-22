options: {
  system = "x86_64-linux";

  nixos.imports = [
    ./hardware-configuration.nix
    ./users
    ./valheim.nix
    ./bittensor/backup-service.nix

    ({ config, household, pkgs, ... }: {
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

      amdgpu.enable = true;

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
            subsystem = "usb";
            pci = "0000:68:00.0";
            kernel = "3-8";
          }
        ];
      };
      security.poly = {
        enable = true;
        services = [ "greetd" ];
        instances = [
          {
            mount = "/tmp";
            source = "/poly/tmp";
            type = "tmpfs";
          }
          {
            mount = "/dev/shm";
            source = "/poly/shm";
            type = "tmpfs";
          }
        ];
      };

      container-mgmt.enable = true;

      virtualisation.libvirtd.enable = true;
      boot.extraModprobeConfig =
        "	options kvm_amd nested=1\n	options kvm ignore_msrs=1 report_ignored_msrs=0\n";

      time.timeZone = "Europe/Belgrade";

      boot.kernel.sysctl."vm.swappiness" = 0; # prioritize RAM
      swapDevices = [{
        device = "/swapfile";
        size = 32 * 1024; # 32 GiB
      }];

      nix.settings = {
        max-jobs = 2;
        cores = 2;
      };
    })
  ];
  nixos.secrets = { valheim.owner = "valheim"; };
}
