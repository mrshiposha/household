{ config, pkgs, ... }: {
  users.users.wally = {
    home = "/home/wally";
    description = "Valentina Shiposha";
    isNormalUser = true;
  };
}
