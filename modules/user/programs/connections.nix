{ config, pkgs, lib, ... }:
with lib;

let cfg = config.connections;
in {
  options.connections = {
    telegram.enable = mkEnableOption "telegram";
    discord.enable = mkEnableOption "discord";
    mattermost.enable = mkEnableOption "mattermost";
    matrix.enable = mkEnableOption "matrix";
  };

  config = with pkgs; {
    home.packages = mkMerge [
      (mkIf cfg.telegram.enable [ telegram-desktop ])
      (mkIf cfg.discord.enable [ discord ])
      (mkIf cfg.mattermost.enable [ mattermost-desktop ])
      (mkIf cfg.matrix.enable [ element-desktop ])
    ];

    unfree.list = with pkgs; mkIf cfg.discord.enable [ discord ];
  };

}
