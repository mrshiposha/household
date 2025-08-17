{ config, lib, pkgs, ... }:
with lib; {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;
    resumeDevice = mkIf config.laptop.enable "/dev/disk/by-label/swap";

    kernelPackages = mkDefault pkgs.linuxPackages_6_12;
  };
}
