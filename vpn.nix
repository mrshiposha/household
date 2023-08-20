{ externalIface }: { config, pkgs, ... }: 
let
  server-key = builtins.getEnv "VPN_SERVER_KEY";
  ipBase = "10.0.0";
  serverIp = "${ipBase}.1";
  vpnPort = 51820;
  dnsPort = 53;
  peers = [
      {
          name = "phone.mrshiposha.home";
          publicKey = "FQSmM1mbw89YBxRgh+1AC7Quhw6kOVfJ6eSBQ0IYgWY=";
          allowedIPs = [ "${ipBase}.7/32" ];
      }

      {
          name = "laptop.mrshiposha.home";
          publicKey = "VNOl7JMNMIJk3h7W3oIRCtUvCBg83DrXTWoQe8ES/E4=";
          allowedIPs = [ "${ipBase}.77/32" ];
      }
  ];
in

assert server-key != "";

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
    pass
  ];

  networking.nat.enable = true;
  networking.nat.externalInterface = externalIface;
  networking.nat.internalInterfaces = [ "wgvpn" ];
  networking.firewall = {
    allowedTCPPorts = [ dnsPort ];
    allowedUDPPorts = [ vpnPort dnsPort ];
  };

  networking.wireguard.interfaces = {
    "wgvpn" = {
      ips = [ "${serverIp}/24" ];
      listenPort = vpnPort;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${serverIp} -o ${externalIface} -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${serverIp} -o ${externalIface} -j MASQUERADE
      '';

      privateKey = server-key;

      inherit peers;
    };
  };

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
  networking.hosts = {
    "${serverIp}" = [ "${config.networking.hostName}.home" ];
    "${ipBase}.77" = [ "laptop.mrshiposha.home" ];
  };
}
