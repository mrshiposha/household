{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    git
    curl
    pciutils
    nix-prefetch-git
    gcc
    glib
    glibc
    lshw
    fwupd
    smartmontools
    unzip
  ];

  services = {
    dbus.enable = true;
    fwupd.enable = true;
  };
}
