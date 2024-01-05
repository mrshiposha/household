let
  unfreePkgs = [
      "steam"
      "steam-original"
      "steam-run"
      "slack"
      "discord"
      "vscode-extension-ms-vscode-remote-remote-ssh"
      "corefonts"
      "vista-fonts"
      "teamspeak-client"
      # "pureref-1.11.1"
      "obsidian"
  ];
  eolPkgs = [
    "electron-25.9.0"
  ];
in
{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) unfreePkgs;
  nixpkgs.config.permittedInsecurePackages = eolPkgs;
}
