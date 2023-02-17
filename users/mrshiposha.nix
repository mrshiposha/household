{ config, pkgs, ... }: {
  imports = [<home-manager/nixos>];
  users.users.mrshiposha = {
    home = "/home/mrshiposha";
    initialPassword = "helloworld";
    description = "Daniel Shiposha";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
  };

  home-manager.users.mrshiposha = import ../functions/home-shell.nix;
}
