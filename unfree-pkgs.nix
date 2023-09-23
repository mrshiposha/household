let unfreePkgs = [
    "steam"
    "steam-original"
    "steam-run"
    "slack"
    "discord"
    "vscode-extension-ms-vscode-remote-remote-ssh"
    "corefonts"
    "vista-fonts"
]; in
{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) unfreePkgs;
}
