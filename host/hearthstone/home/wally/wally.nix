{
  common,
  username,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" { inherit common username stateVersion; })
    (import "${common}/functions/home-file.nix" {
      name = "sway-common";
      source-root = "${common}/home";
      path = ".config/sway/config";
    })
    "${common}/home/terminal.nix"
    "${common}/home/firefox.nix"
  ];
}
