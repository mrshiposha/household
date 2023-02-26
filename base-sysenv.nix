{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    git
    curl
    pciutils
    nix-prefetch-git
    gnupg
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "qt";
    };
  };

  services.dbus.enable = true;
}
