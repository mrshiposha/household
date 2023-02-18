{ lib, ... }: let users = [
  "mrshiposha"
  "wally"
]; in
let imports = (map (user: ./${user}.nix) users) ++ [(import ../functions/home-manager/home-manager.nix)];
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
