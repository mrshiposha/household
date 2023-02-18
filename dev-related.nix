{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    git
    curl
  ];
}
