{ config, pkgs, lib, ... }: {
  boot.kernelPackages =
    if config.virtualisation.virtualbox.guest.enable
    then null
    else pkgs.linuxPackages_6_1;
}
