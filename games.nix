{ pkgs, ... }: with pkgs; {
  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = [
        "${ncurses.out}/lib"
      ];
    };
    systemPackages = [
      mangohud
    ];
  };

  programs.steam.enable = true;


}
