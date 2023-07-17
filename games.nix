{ pkgs, ... }: with pkgs;
let nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = [
        "${ncurses.out}/lib"
      ];
    };
    systemPackages = [
      nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
      winetricks
      lutris
      transmission-gtk
      mangohud
      gamemode
    ];
  };

  programs.steam.enable = true;


}
