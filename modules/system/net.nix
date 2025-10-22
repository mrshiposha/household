{ config, lib, ... }:
with lib;

let cfg = config.net;
in {
  options.net = {
    wireless.enable = mkEnableOption "wireless networking";
    ssh.enable = mkEnableOption "ssh";
    netbird.enable = mkEnableOption "netbird client";
  };

  config = {
    networking = {
      useNetworkd = true;
      wireless.iwd.enable = cfg.wireless.enable;
      nameservers = [ "1.1.1.1" "8.8.8.8" ];
      nftables.enable = true;
    };

    systemd.network.enable = true;

    services.openssh = {
      enable = cfg.ssh.enable;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        LogLevel = "VERBOSE";
      };
    };
    services.netbird.enable = cfg.netbird.enable;

    services.fail2ban.enable = cfg.ssh.enable;

    programs.wireshark.enable = true;
  };
}
