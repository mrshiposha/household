{
  common-home,
  username,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common-home}/base.nix" username stateVersion)
    (import "${common-home}/config.nix" common-home)
    "${common-home}/terminal.nix"
  ];
}
