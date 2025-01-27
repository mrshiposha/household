{
  system = "x86_64-linux";

  nixos.imports = [
    ./hardware-configuration.nix
    ./users

    ({ config, household, ... }: {
      system.stateVersion = "23.11";
      networking.hostName = "satellite";

      nix.buildMachines = [{
        hostName = "hearthstone";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshUser = "nix-remote";
        sshKey = "/root/.ssh/buildhost/hearthstone/id_ecdsa";
        speedFactor = 10;
        supportedFeatures = [ "kvm" "big-parallel" ];
      }];
      nix.distributedBuilds = true;

      nix.extraOptions = ''
        builders-use-substitutes = true
        cores = 12
      '';

      laptop.enable = true;
      intel.enable = true;

      gui = {
        enable = true;
        games.enable = true;
        greeter.seat0.theme = household.greeterThemeFromUserTheme
          config.home-manager.users.mrshiposha;
      };
      security.poly = {
        enable = true;
        services = [ "greetd" ];
      };

      container-mgmt.enable = true;

      services.localtimed.enable = true;
    })
  ];

  nixos.secrets.dev-email.owner = "mrshiposha";
}
