{ config, pkgs, ... }: {
  imports = [
    ./mrshiposha.nix
    ./wally.nix
  ];
}
