{ config, pkgs, lib, ... }:
let system-version = import ../functions/system-version.nix;
in let home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system-version}.tar.gz";
in {
  imports = [
    ./mrshiposha.nix
    ./wally.nix
  ];

  home-manager.users = lib.mapAttrs
    (user: _: import ../functions/home-manager/home.nix user)
    config.users.users;
}
