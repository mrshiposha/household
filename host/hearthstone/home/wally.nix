{
  common-home,
  username,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common-home}/base.nix" username stateVersion)
  ];
}
