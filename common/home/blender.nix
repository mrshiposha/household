{ pkgs, ... }: with pkgs; {
  home.packages = [
    (callPackage ../packages/blender.nix {})
    # (
    #   pkgs.blender.override {
    #     hipSupport = true;
    #   }
    # )
  ];
}
