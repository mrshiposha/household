{ config, pkgs, lib, ... }: {
  boot.kernelPackages =
    if config.virtualisation.virtualbox.guest.enable
    then pkgs.linuxPackages
    else pkgs.linuxPackages_6_1;

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = false;
    "net.ipv6.conf.all.forwarding" = false;
  };
}
