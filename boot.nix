{ silentBoot, resolution }: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = resolution;
      };
    };
  } // (if silentBoot then {
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "loglevel=4"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=4"
      "udev.log_priority=4"
    ];
  } else {});
}
