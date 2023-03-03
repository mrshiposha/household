{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    cinnamon.nemo
  ];
}
