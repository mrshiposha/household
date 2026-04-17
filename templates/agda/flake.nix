{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          _module.args.pkgs = pkgs;

          devShells.default =
            with pkgs;
            mkShell rec {
              packages = with pkgs; [
                (agda.withPackages (
                  p: with p; [
                    standard-library
                  ]
                ))
              ];
            };
        };
    };
}
