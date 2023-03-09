{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    cinnamon.nemo
  ];

  services.gvfs.enable = true;
}
