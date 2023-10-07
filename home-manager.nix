tarball: { config, pkgs, lib, ... }:
let
  common = ./common;
  usernixes = builtins.filter
    (file: lib.hasSuffix ".nix" file)
    (lib.filesystem.listFilesRecursive ./host/${config.networking.hostName}/home);
in {
  imports = [(import "${tarball}/nixos")];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users = lib.listToAttrs (
      map
        (usernix: 
          let
            username = lib.removeSuffix ".nix" (baseNameOf usernix);
            private = dirOf usernix;
          in {
          name = username;
          value = import usernix {
            inherit common private username;
            person = config.users.users.${username}.description;
          };
        })
        usernixes
    );
  };
}
