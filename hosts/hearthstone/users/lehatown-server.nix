{ config, household, lib, ... }:
let
  enableServer = true;

  user = "lehatown-server";
  ports = {
    ui = 8443;
    update = 27017;
    game = 27016;
  };

  allowedPorts = [ ports.ui ports.update ports.game ];
in {
  users.users.${user} = {
    group = user;
    isNormalUser = true;
    linger = true;
  };
  users.groups.${user} = { };

  home-manager.users.${user} = {
    imports = [ household.modules.user ];

    zsh.enable = true;
    xdg.enable = true;

    lehatown = {
      enable = enableServer;

      inherit ports;
    };

    home.stateVersion = config.system.stateVersion;
  };

  networking.firewall.allowedTCPPorts = lib.mkIf enableServer allowedPorts;
  networking.firewall.allowedUDPPorts = lib.mkIf enableServer allowedPorts;

}
