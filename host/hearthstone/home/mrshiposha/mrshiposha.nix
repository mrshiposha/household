{
  common,
  username,
  person,
  stateVersion
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" username stateVersion)
    (import "${common}/home/git.nix" person "${username}@gmail.com")
    (import "${common}/functions/home-file.nix" "sway" "${common}/home" ".config/sway/config")
    "${common}/home/terminal.nix"
  ];
}
