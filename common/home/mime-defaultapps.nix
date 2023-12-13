{ pkgs, lib, ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
        "application/x-shellscript" = lib.mkDefault ["Alacritty.desktop"];
        "application/x-archive" = lib.mkDefault ["xarchiver.desktop"];
    };
  };
}
