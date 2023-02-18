{ lib, ... }:
let 
  system-version = import ../functions/system-version.nix;
  users = [
    "mrshiposha"
    "wally"
  ];
in let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system-version}.tar.gz";
  imports = (map (user: ./${user}.nix) users) ++ [(import "${home-manager}/nixos")];
in {
  inherit imports;

  home-manager.users = lib.listToAttrs (
    map
      (user: {
        name = user;
        value = import ../functions/home-manager/home.nix user;
      })
      users
  );
}
