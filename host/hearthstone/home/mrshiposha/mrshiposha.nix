{
  common,
  username,
  person,
  stateVersion,
  ...
}:
{ pkgs, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" { inherit common username stateVersion; })
    (import "${common}/home/git.nix" { name = person; email = "${username}@gmail.com"; })
    (import "${common}/functions/home-file.nix" {
      name = "sway-common";
      source-root = "${common}/home";
      path = ".config/sway/config";
    })
    "${common}/home/terminal.nix"
    "${common}/home/vscode.nix"
    "${common}/home/firefox.nix"
  ];
}
