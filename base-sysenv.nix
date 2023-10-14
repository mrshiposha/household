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

  fonts = {
    fonts = [
      meslo-lgs-nf
      noto-fonts
      mononoki
      corefonts
      vistafonts
    ];
    fontconfig.enable = true;
    fontDir.enable = true;
  };

  services = {
    dbus.enable = true;
    fwupd.enable = true;
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.enableRedistributableFirmware = true;

  nixpkgs.overlays = [
    (self: super: {
      fcitx-engines = fcitx5;
    })
  ];
}
