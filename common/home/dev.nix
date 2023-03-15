{ pkgs, ... }: with pkgs; {
  home.packages = [
    direnv
    rustup
    gnumake
    cmake
    nodejs

    nodePackages.mermaid-cli
  ];

  services.lorri.enable = true;
}
