{ pkgs, lib, ... }: let userfiles = lib.filesystem.listFilesRecursive ./users; in {
  imports = userfiles ++ [(import ./functions/home-manager/home-manager.nix)];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users = lib.listToAttrs (
    map
      (userfile: let user = lib.removeSuffix ".nix" (baseNameOf userfile); in {
        name = user;
        value = import ./functions/home-manager/home.nix user;
      })
      userfiles
  );

  environment.systemPackages = [
    pkgs.home-manager
  ];
}
