{
  common,
  username,
  ...
}:
{ pkgs, lib, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" { inherit common username; })
    (import "${common}/functions/setup-common-config.nix" {
      inherit lib;
      config-dir = "${common}/home/.config";
    })
    "${common}/home/launcher.nix"
    (import "${common}/home/terminal.nix" { inherit common; })
    "${common}/home/sys-monitor.nix"
    "${common}/home/firefox.nix"
    "${common}/home/telegram.nix"
    "${common}/home/teamspeak.nix"
    "${common}/home/discord.nix"
    "${common}/home/image-view.nix"
    "${common}/home/vlc.nix"
    "${common}/home/3d.nix"
    "${common}/home/office.nix"
    "${common}/home/calc.nix"
  ];
}
