{ lib, ... }: let userfiles = lib.filesystem.listFilesRecursive ./users; in {
  imports = userfiles ++ [(import ./functions/home-manager/home-manager.nix)];

  home-manager.users = lib.listToAttrs (
    map
      (userfile: let user = lib.removeSuffix (baseNameOf userfile) ".nix"; in {
        name = user;
        value = import ./functions/home-manager/home.nix user;
      })
      userfiles
  );
}
