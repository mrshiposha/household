{ pkgs, ... }: with pkgs; {
  home.packages = [
    gnome.gedit
  ];
}
