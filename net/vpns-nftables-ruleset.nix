{ externalIface }: { config, lib, ... }:
let
    join = lib.strings.concatStringsSep;
    definedVPNs = config.networking.wireguard.interfaces;
    ifaceNames = builtins.attrNames definedVPNs;
    netIps = map (iface: builtins.elemAt iface.ips 0)
                   (builtins.attrValues definedVPNs);

    ifaces = join "," ifaceNames;
    nets = join "," netIps;
    net-forward-accept = join "," (
        map (ip: "${ip} . ${ip} : accept") netIps
    );
in
{
  networking.nftables.ruleset = ''
    table ip vpn {
      set ifaces {
        type ifname
        elements = { ${ifaces} }
      }

      set nets {
        type ipv4_addr
        flags interval
        elements = { ${nets} }
      }

      map net-forward-accept {
        type ipv4_addr . ipv4_addr : verdict
        flags interval
        elements = { ${net-forward-accept} }
      }

      chain nat {
        type nat hook postrouting priority srcnat; policy accept;

        meta iifname @ifaces meta oifname ${externalIface} masquerade
      }

      chain forward {
        type filter hook forward priority filter; policy accept;

        ip saddr . ip daddr vmap @net-forward-accept
        ip saddr @nets ip daddr 192.168.0.0/16 drop
        ip saddr @nets ip daddr @nets drop
      }
    }
  '';
}
