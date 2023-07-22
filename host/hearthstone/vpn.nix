let 
  root = ./../..;
  ipBase = "10.0.0";
in (import "${root}/vpn-server.nix" {
    externalIface = "eno1";
    internalIface = "wgvpn";
    ip = "${ipBase}.1/24";
    port = 51820;
    peers = [
        {
            name = "Daniel-Phone";
            publicKey = "FQSmM1mbw89YBxRgh+1AC7Quhw6kOVfJ6eSBQ0IYgWY=";
            allowedIPs = [ "${ipBase}.7/32" ];
        }

        {
            name = "Daniel-Laptop";
            publicKey = "VNOl7JMNMIJk3h7W3oIRCtUvCBg83DrXTWoQe8ES/E4=";
            allowedIPs = [ "${ipBase}.77/32" ];
        }
    ];
})
