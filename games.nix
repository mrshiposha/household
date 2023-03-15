{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    lutris
  ];

  programs.steam.enable = true;
}
