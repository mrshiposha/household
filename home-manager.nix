host: { pkgs, lib, ... }:
let
  common-home = ./common/home;
  userhomes = lib.filesystem.listFilesRecursive ./host/${host}/home; 
  system-version = import ./common/system-version.nix;
in let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system-version}.tar.gz";
in {
  imports = [(import "${home-manager}/nixos")];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users = lib.listToAttrs (
      map
        (userhome: let username = lib.removeSuffix ".nix" (baseNameOf userhome); in {
          name = username;
          value = import userhome {
            inherit common-home username;
            person = (import ./users/${username}.nix).users.users.${username}.description;
            stateVersion = system-version;
          };
        })
        userhomes
    );
  };
}
