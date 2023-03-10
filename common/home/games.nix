{ pkgs, ... }: with pkgs; {
  home.packages = [
    lutris
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["steam"];
}
