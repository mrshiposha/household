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
      wineWowPackages.stable
      wine
      (wine.override { wineBuild = "wine64"; })
      wine64
      wineWowPackages.staging
      winetricks
      wineWowPackages.waylandFull

      lutris
      transmission-gtk
      mangohud
      gamemode
    ];
  };

  programs.steam.enable = true;


}
