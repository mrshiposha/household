{ pkgs, ... }: with pkgs; {
  home.packages = [
    rustup
    gnumake
    cmake
    nodejs
    (agda.withPackages (p: [ p.standard-library ]))

    nodePackages.mermaid-cli
  ];

  services.lorri.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
