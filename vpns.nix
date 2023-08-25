{ externalIface }: { config, pkgs, lib, ... }: 
let
  server-key = builtins.getEnv "VPN_SERVER_KEY";
  vpn = {
    iface,
    ipBase,
    vpnPort,
    peers,
  }: { config, pkgs, ... }:
  let
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
  {
    networking.nat.internalInterfaces = [ iface ];
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

        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${serverIp} -o ${externalIface} -j MASQUERADE
        '';

        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${serverIp} -o ${externalIface} -j MASQUERADE
        '';

        privateKey = server-key;

        peers = vpnPeers;
      };
    };
    networking.hosts = {
      "${serverIp}" = [ "${config.networking.hostName}.home" ];
    } // dnsHosts;

    services.fail2ban.ignoreIP = [ "${serverIp}/24" ];
  };
in

assert server-key != "";

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
    pass
  ];

  imports = [
    (vpn {
      iface = "vpn.shiposha.jr";
      ipBase = "10.0.0";
      vpnPort = 51820;
      peers = {
        "phone.mrshiposha.home" = {
            ip = 7;
            publicKey = "FQSmM1mbw89YBxRgh+1AC7Quhw6kOVfJ6eSBQ0IYgWY=";
        };

        "laptop.mrshiposha.home" = {
            ip = 77;
            publicKey = "VNOl7JMNMIJk3h7W3oIRCtUvCBg83DrXTWoQe8ES/E4=";
        };
      };
    })

    (vpn {
      iface = "vpn.shiposha.sr";
      ipBase = "10.30.0";
      vpnPort = 51821;
      peers = {
        "macbook.shiposha.home" = {
          ip = 7;
          publicKey = "t1Bn5hor5eqaTie2gACMjMp7jTJEzryemB2hwx3TsDY=";
        };
      };
    })
  ];

  networking.nat.enable = true;
  networking.nat.externalInterface = externalIface;

  services.dnsmasq = {
    enable = true;
    settings = {
      domain-needed = true;
      bogus-priv = true;
      cache-size = 1000;
      server = [
        "1.1.1.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
    };
  };
}
