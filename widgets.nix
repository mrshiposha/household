{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    eww
    gtk3
    gtk-layer-shell
    pango
    gdk-pixbuf
    cairo
    glib
    glibc
    gcc
  ];
}
