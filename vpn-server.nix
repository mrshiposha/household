{ externalIface, internalIface, ip, port, peers }: { pkgs, ... }: 
let server-key = builtins.getEnv "VPN_SERVER_KEY";
in 

assert server-key != "";

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
    pass
  ];

  networking.nat.enable = true;
  networking.nat.externalInterface = externalIface;
  networking.nat.internalInterfaces = [ internalIface ];
  networking.firewall = {
    allowedUDPPorts = [ port ];
  };

  networking.wireguard.interfaces = {
    "${internalIface}" = {
      ips = [ ip ];
      listenPort = port;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${ip} -o ${externalIface} -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${ip} -o ${externalIface} -j MASQUERADE
      '';

      privateKey = server-key;

      inherit peers;
    };
  };
}
