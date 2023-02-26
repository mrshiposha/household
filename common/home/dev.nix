{ pkgs, ... }: with pkgs; {
  home.packages = [
    gcc
    rustup
  ];
}
