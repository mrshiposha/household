{ pkgs, ... }: with pkgs; {
  home.packages = [
    xorg.xlsclients
  ];
}
