{ config, lib, pkgs, ... }:
with lib; {
  options.amdgpu.enable =
    mkEnableOption "AMD GPU monitoring and configuration tools";

  config = mkIf config.amdgpu.enable {
    environment.systemPackages = with pkgs; [ lact ];

    systemd.services.lact = {
      description = "AMDGPU Control Daemon";
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
      enable = true;
    };
  };
}
