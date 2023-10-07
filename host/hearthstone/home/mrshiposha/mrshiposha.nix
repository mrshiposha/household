{
  common,
  username,
  person,
  ...
}:
{ pkgs, lib, ... }:
let cfg-vars = "VPN_SERVER_KEY=$(pass show vpn/server-key)";
in with pkgs; {
  imports = [
    (import "${common}/home/base.nix" {
      inherit common username;
      zshExtras = ''
        eval "$(direnv hook zsh)"

        system-rebuild() {
          sudo ${cfg-vars} nixos-rebuild "$@"
        }

        system-cfg-repl() {
          ${cfg-vars} nix repl --file '<nixpkgs/nixos>'
        }
      '';
    })
    (import "${common}/home/git.nix" { name = person; email = "${username}@gmail.com"; })
    (import "${common}/functions/setup-common-config.nix" {
      inherit lib;
      config-dir = "${common}/home/.config";
    })
    "${common}/home/dev.nix"
    "${common}/home/launcher.nix"
    (import "${common}/home/terminal.nix" { inherit common; })
    "${common}/home/graphviz.nix"
    "${common}/home/hardinfo.nix"
    "${common}/home/sys-monitor.nix"
    "${common}/home/gparted.nix"
    "${common}/home/unetbootin.nix"
    "${common}/home/vscode.nix"
    "${common}/home/firefox.nix"
    "${common}/home/telegram.nix"
    "${common}/home/gedit.nix"
    "${common}/home/slack.nix"
    "${common}/home/discord.nix"
    "${common}/home/image-view.nix"
    "${common}/home/vlc.nix"
    "${common}/home/calc.nix"
    "${common}/home/libresprite.nix"
    "${common}/home/qpwgraph.nix"
    "${common}/home/blender.nix"
  ];
}
