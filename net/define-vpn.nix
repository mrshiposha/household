{
    iface,
    ipBase,
    vpnPort,
    peers,
}: { config, pkgs, lib, ... }:

let
  server-key = builtins.getEnv "VPN_SERVER_KEY";

  serverIp = "${ipBase}.1";
  dnsPort = 53;
  peerIp = peerInfo: "${ipBase}.${builtins.toString peerInfo.ip}";

  vpnPeers = builtins.attrValues (
      builtins.mapAttrs (
      name: peerInfo: {
          inherit name;
          publicKey = peerInfo.publicKey;
          allowedIPs = [ "${peerIp peerInfo}/32" ];
      } 
      ) peers
  );
  dnsHosts = lib.attrsets.mapAttrs' (
      name: peerInfo: lib.nameValuePair (peerIp peerInfo) [ name ]
  ) peers;
in
assert server-key != "";
{
  networking.firewall = {
      allowedUDPPorts = [ vpnPort ];
      interfaces."${iface}" = {
        allowedTCPPorts = [ dnsPort ];
        allowedUDPPorts = [ dnsPort ];
      };
  };

  networking.wireguard.interfaces = {
    "${iface}" = {
      ips = [ "${serverIp}/24" ];
      listenPort = vpnPort;
      privateKey = server-key;
      peers = vpnPeers;
    };
  };
  networking.hosts = {
    "${serverIp}" = [ "${config.networking.hostName}.home" ];
  } // dnsHosts;

  services.fail2ban.ignoreIP = [ "${serverIp}/24" ];
}
