{
  common,
  username,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" username stateVersion)
    (import "${common}/functions/home-file.nix" "sway" "${common}/home" ".config/sway/config")
    "${common}/home/terminal.nix"
  ];
}
