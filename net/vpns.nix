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
    net = "${ipBase}.0/24";
    nftAdd = "${pkgs.nftables}/bin/nft add";
    nftDel = "${pkgs.nftables}/bin/nft delete";
  in
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

        postSetup = ''
          ${nftAdd} element ip vpn ifaces { ${iface} }
          ${nftAdd} element ip vpn nets { ${net} }
          ${nftAdd} element ip vpn net-forward-accept { ${net} . ${net} : accept }
        '';

        postShutdown = ''
          ${nftDel} element ip vpn ifaces { ${iface} }
          ${nftDel} element ip vpn nets { ${net} }
          ${nftDel} element ip vpn net-forward-accept { ${net} . ${net} }
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

  networking.nftables.ruleset = ''
    table ip vpn {
      set ifaces {
        type ifname
      }

      set nets {
        type ipv4_addr
        flags interval
      }

      map net-forward-accept {
        type ipv4_addr . ipv4_addr : verdict
        flags interval
      }

      chain nat {
        type nat hook postrouting priority srcnat; policy accept;

        meta iifname @ifaces meta oifname ${externalIface} masquerade
      }

      chain forward {
        type filter hook forward priority filter; policy accept;

        ip saddr . ip daddr vmap @net-forward-accept
        ip saddr @nets ip daddr @nets drop
      }
    }
  '';

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
