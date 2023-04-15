{ pkgs, ... }: with pkgs; {
  home.packages = [
    direnv
    rustup
    gnumake
    cmake
    nodejs
    (agda.withPackages (p: [ p.standard-library ]))

    nodePackages.mermaid-cli
  ];

  services.lorri.enable = true;
}
