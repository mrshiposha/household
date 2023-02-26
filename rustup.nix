{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    rustup
  ];
}
