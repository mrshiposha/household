{ pkgs, ... }:
with pkgs;
let home = ../../common/home; in {
  imports = [
    (import ${home}/base.nix "wally")
  ];
}
