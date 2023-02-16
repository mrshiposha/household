{ config, pkgs, ... }: {
  import = [
    ./mrshiposha.nix
    ./wally.nix
  ];
}
