{ config, pkgs, lib, ... }: {
  boot.kernelPackages =
    if config.virtualisation.virtualbox.guest.enable
    then pkgs.linuxPackages
    else pkgs.linuxPackages_6_6;
}
