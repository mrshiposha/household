host: { pkgs, lib, ... }:
let
  common = ./common;
  usernixes = builtins.filter
    (file: lib.hasSuffix ".nix" file)
    (lib.filesystem.listFilesRecursive ./host/${host}/home); 
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
        (usernix: 
          let
            username = lib.removeSuffix ".nix" (baseNameOf usernix);
            private = dirOf usernix;
          in {
          name = username;
          value = import usernix {
            inherit common private username;
            person = (import ./users/${username}.nix).users.users.${username}.description;
            stateVersion = system-version;
          };
        })
        usernixes
    );
  };
}
