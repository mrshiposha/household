{ config, lib, pkgs, ... }:
with lib; {
  options.mfp.enable = mkEnableOption "enable multi-function printers";
  config = mkIf config.mfp.enable {
    hardware.sane.enable = true;
    services.printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    environment.systemPackages = with pkgs.kdePackages; [ skanlite skanpage ];
  };
}
