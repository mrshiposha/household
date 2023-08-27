{ externalIface }: { config, pkgs, lib, ... }: 
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
    pass
  ];

  imports = [
    (import ./vpns-nftables-ruleset.nix { inherit externalIface; })

    (import ./define-vpn.nix {
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

    (import ./define-vpn.nix {
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
