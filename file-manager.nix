{ pkgs, ... }: with pkgs; {
  programs.thunar = {
    enable = true;
    plugins = [
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xarchiver
      nnn
    ];
  };

  services.gvfs.enable = true;
}
