{ pkgs, ... }: with pkgs; {
  home.packages = [
    (callPackage ../packages/blender.nix {})
  ];
}
