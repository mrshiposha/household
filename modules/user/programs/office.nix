{ config, lib, pkgs, ... }:
with lib; {
  options.office.enable = mkEnableOption "office programs";
  config = mkIf config.office.enable {
    home.packages = with pkgs; [ libreoffice-qt hunspell hunspellDicts.ru_RU ];
  };
}
