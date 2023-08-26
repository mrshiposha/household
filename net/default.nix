{ vpnExternalIface }: {
    imports = [
        (import ./vpns.nix { externalIface = vpnExternalIface; })
    ];

    networking.nftables.enable = true;
}

