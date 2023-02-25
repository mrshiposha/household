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
    (import "${common-home}/config.nix" common-home)
    "${common-home}/terminal.nix"
  ];
}
