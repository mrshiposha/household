{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    cinnamon.nemo
    gnome.file-roller
  ];

  services.gvfs.enable = true;
}
