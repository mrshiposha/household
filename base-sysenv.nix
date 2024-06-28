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
    packages = [
      meslo-lgs-nf # needed for zsh (by VSCode, see the corresponding config)
      mononoki
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["MesloLGS NF"];
    };

    fontDir.enable = true;
  };

  services = {
    dbus.enable = true;
    fwupd.enable = true;
    logind.killUserProcesses = true;
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "repl-flake"
  ];

  hardware.enableRedistributableFirmware = true;
}
