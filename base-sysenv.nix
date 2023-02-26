{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    git
    curl
    pciutils
    nix-prefetch-git
    gnupg
  ];

  programs = {
    gnupg = {
      enable = true;
      pinentryFlavor = "qt";
    };
  };

  services.dbus.enable = true;
}
