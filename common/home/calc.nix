{ pkgs, ... }: with pkgs; {
  home.packages = [
    gnome.gnome-calculator
  ];
}
