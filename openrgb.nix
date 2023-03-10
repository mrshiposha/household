{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    openrgb
  ];
}
