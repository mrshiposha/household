{ pkgs, lib, ... }:
let 
  userfiles = lib.filesystem.listFilesRecursive ./users; 
  system-version = import ../system-version.nix;
in let
  users = map (userfile: lib.removeSuffix ".nix" (baseNameOf userfile)) userfiles;
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system-version}.tar.gz";
in {
  imports = [(import "${home-manager}/nixos")];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users = lib.listToAttrs (
    map
      (user: {
        name = user;
        value = import ./common/home-manager/setup-home.nix user;
      })
      users
  );

  environment.systemPackages = [
    pkgs.home-manager
  ];
}
