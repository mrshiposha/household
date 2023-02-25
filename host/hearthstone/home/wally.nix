{
  common-home,
  username,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common-home}/base.nix" username stateVersion)
    "${common-home}/config.nix"
    "${common-home}/terminal.nix"
  ];
}
