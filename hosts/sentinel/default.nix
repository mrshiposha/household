options: {
  system = "x86_64-linux";

  nixos.imports = [
    ./hardware-configuration.nix
    ./users

    ({ config, household, ... }: {
      system.stateVersion = "24.05";
      networking.hostName = "sentinel";
      intel.enable = true;

      networking.interfaces.enp3s0 = {
        ipv6.addresses = options.ip.addr.v6;
        ipv4.addresses = options.ip.addr.v4;
        useDHCP = true;
      };

      services = { "shiposha.com".enable = true; };

      time.timeZone = "Europe/Belgrade";
    })
  ];
  nixos.secrets = {
    zitadel.owner = "zitadel";
    coturn.owner = "turnserver";
    netbird-client.owner = "root";
    netbird-key.owner = "root";
    netbird-turn.owner = "root";
  };
}
