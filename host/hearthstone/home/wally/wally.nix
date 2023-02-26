{
  common,
  username,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" username stateVersion)
    (import "${common}/functions/home-file.nix" "sway-common" "${common}/home" ".config/sway/config")
    (import "${common}/functions/home-file.nix" "sway-private" "${private}" ".config/compositor/config")
    "${common}/home/terminal.nix"
  ];
}
