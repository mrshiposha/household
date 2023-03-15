{
  imports = [
    ../groups/steam.nix
  ];
  users.users.wally = {
    home = "/home/wally";
    description = "Valentina Shiposha";
    extraGroups = [ "steam" ];
    isNormalUser = true;
  };
}
