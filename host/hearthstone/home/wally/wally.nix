{
  common,
  username,
  stateVersion,
  ...
}:
{ pkgs, lib, ... }: with pkgs; {
  imports = [
    (import "${common}/home/base.nix" { inherit common username stateVersion; })
    (import "${common}/functions/setup-common-config.nix" {
      inherit lib;
      config-dir = "${common}/home/.config";
    })
    "${common}/home/launcher.nix"
    (import "${common}/home/terminal.nix" { inherit common; })
    "${common}/home/sys-monitor.nix"
    "${common}/home/firefox.nix"
    "${common}/home/telegram.nix"
    "${common}/home/discord.nix"
    "${common}/home/image-view.nix"
    "${common}/home/vlc.nix"
    "${common}/home/blender.nix"
    "${common}/home/calc.nix"
  ];
}
