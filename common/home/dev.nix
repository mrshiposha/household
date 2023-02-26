{ pkgs, ... }: with pkgs; {
  home.packages = [
    rustup
  ];
}
