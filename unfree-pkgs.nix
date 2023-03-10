let unfreePkgs = [
    "steam"
    "steam-original"
]; in
{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) unfreePkgs;
}
