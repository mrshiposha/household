{ config, pkgs, ... }:
with pkgs; {
  unfree.list = [ valheim-server steamworks-sdk-redist ];

  services.valheim = {
    enable = true;
    port = 40787;
    serverName = "Blenderast Server";
    worldName = "Blenderast";
    openFirewall = true;
    password = config.secrets.valheim.secret.path;
  };
}
