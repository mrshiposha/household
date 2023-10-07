{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.openrazer-daemon
    pkgs.polychromatic
  ];
  hardware.openrazer.enable = true;
}
