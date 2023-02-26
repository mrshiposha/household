{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    eww-wayland
    gtk3
    gtk-layer-shell
    pango
    gdk-pixbuf
    cairo
  ];
}
