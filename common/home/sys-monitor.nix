{ pkgs, ... }: with pkgs; {
  home.packages = [
    gnome.gnome-system-monitor
    psensor
  ];
}
