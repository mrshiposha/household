host: { pkgs, lib, ... }:
let 
  userhomes = lib.filesystem.listFilesRecursive ./host/${host}/home; 
  system-version = import ./common/system-version.nix;
in let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system-version}.tar.gz";
in {
  imports = [(import "${home-manager}/nixos")];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users = lib.listToAttrs (
    map
      (userhome: let user = lib.removeSuffix ".nix" (baseNameOf userhome); in {
        name = user;
        value = import userhome;
      })
      userhomes
  );

  environment.systemPackages = [
    pkgs.home-manager
  ];
}
