let unfreePkgs = [
    "steam"
    "steam-original"
    "slack"
    "discord"
]; in
{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) unfreePkgs;
}
