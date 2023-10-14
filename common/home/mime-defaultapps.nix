{ pkgs, lib, ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
        "application/x-shellscript" = lib.mkDefault ["Alacritty.desktop"];
    };
  };
}
