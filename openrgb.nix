{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    openrgb
  ];
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
}
