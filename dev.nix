{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    gcc
    rustup
  ];
}
