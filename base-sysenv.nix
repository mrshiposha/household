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
    unrar-wrapper
  ];

  services = {
    dbus.enable = true;
    fwupd.enable = true;
  };

  nix.settings.auto-optimise-store = true;

  hardware.enableRedistributableFirmware = true;

  nixpkgs.overlays = [
    (self: super: {
      fcitx-engines = fcitx5;
    })
  ];
}
