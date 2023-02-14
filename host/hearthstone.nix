{ config, pkgs, ... }:
let root = ./..;
in
{
  imports = [
    "${root}"/timezone.nix
    "${root}"/shell.nix
    "${root}"/users/mrshiposha.nix
  ];

  networking.hostname = "hearthstone";
  users.mutableUsers = false;
}
