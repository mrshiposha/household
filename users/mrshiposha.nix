{
  imports = [
    ../groups/steam.nix
  ];
  users.users.mrshiposha = {
    home = "/home/mrshiposha";
    initialPassword = "helloworld";
    description = "Daniel Shiposha";
    extraGroups = [ "wheel" "steam" ];
    isNormalUser = true;
  };
}
