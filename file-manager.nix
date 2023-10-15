{ pkgs, ... }: with pkgs; {
  programs.thunar = {
    enable = true;
    plugins = [
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xarchiver
    ];
  };

  services.gvfs.enable = true;
}
