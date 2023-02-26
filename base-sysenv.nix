{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    git
    curl
    pciutils
    nix-prefetch-git
    gnupg
    pinentry
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "qt";
    };
  };

  services.dbus.enable = true;
}
