{
  common,
  username,
  person,
  stateVersion,
  ...
}:
{ pkgs, lib, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" { inherit common username stateVersion; })
    (import "${common}/home/git.nix" { name = person; email = "${username}@gmail.com"; })
    (import "${common}/functions/setup-common-config.nix" {
      inherit lib;
      config-dir = "${common}/home/.config";
    })
    "${common}/home/dev.nix"
    "${common}/home/launcher.nix"
    (import "${common}/home/terminal.nix" { inherit common; })
    "${common}/home/vscode.nix"
    "${common}/home/firefox.nix"
    "${common}/home/telegram.nix"
    "${common}/home/image-view.nix"
    "${common}/home/vlc.nix"
    "${common}/home/games.nix"
  ];
}
