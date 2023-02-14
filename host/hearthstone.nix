{ config, pkgs, ... }:
let root = ./..;
in
{
  imports = [
    "${root}"/bootloader.nix
    "${root}"/system.nix
    "${root}"/timezone.nix
    "${root}"/shell.nix
    "${root}"/users/mrshiposha.nix
  ];

  networking.hostname = "hearthstone";
  users.mutableUsers = false;
}
