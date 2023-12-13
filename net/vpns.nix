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
        "mbp.shiposha.home" = {
          ip = 2;
          publicKey = "qn4klDZpLYBT13p0h5ICY7kBy1UoKvqzhzt5HnTdaUM=";
        };

        "dachamac.shiposha.home" = {
          ip = 3;
          publicKey = "crQjlzFABJniGvX+txwbZIabOgdtm1XFxBfc3Cl+eXw=";
        };

        "phone.shiposha.home" = {
          ip = 4;
          publicKey = "JSHiEmdPT/6IIUAH0T65PwuMNds+mVov02A4xcq4VCg=";
        };

        "hack.shiposha.home" = {
          ip = 5;
          publicKey = "a1/5TVe7e4eMYWwN1SRRVfYx7HMN1eyeffhiwIk2W3w=";
        };

        "win10.shiposha.home" = {
          ip = 6;
          publicKey = "4iBvIv0fwRpfAKAmpgcwPB2gdhEGZjTlupDCcrdQ700=";
        };

        "phone.esina.home" = {
          ip = 20;
          publicKey = "5WrkANeWSE5VH2d0PWiw5LfxPGpbAuh95VfakOoXPAc=";
        };

        "ipad.esina.home" = {
          ip = 21;
          publicKey = "C8lQivi2s2uIrQYlfEINANCoC9r2yDR+WzM+xQ40iQA=";
        };

        "macbook.esina.home" = {
          ip = 22;
          publicKey = "fNXFNoqYP46JAK1We+4jbRDOjI0YJisPAidHk5kyiFQ=";
        };
      };
    })

    (import ./define-vpn.nix {
      iface = "vpn.makhov";
      ipBase = "10.60.0";
      vpnPort = 51822;
      peers = {
        "alexander.makhov" = {
          ip = 2;
          publicKey = "pugiTqxafBmclY++zR7cjfquufOAkx+ykntmhzJdYxs=";
        };
      };
    })
  ];

  services.fail2ban.ignoreIP = [ "10.0.0.0/24" ];

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
