{
  common-home,
  username,
  person,
  stateVersion
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common-home}/base.nix" username stateVersion)
    (import "${common-home}/git.nix" person "${username}@gmail.com")
    "${common-home}/launcher.nix"
    "${common-home}/terminal.nix"
  ];
}
