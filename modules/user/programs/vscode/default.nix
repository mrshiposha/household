{ config, pkgs, lib, ... }:
with lib;
let cfg = import ./cfg.nix;
in {
  options.vscode.enable = mkEnableOption "vscode";

  config = mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      # package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles.default = {
        extensions = import ./extensions.nix pkgs;
        userSettings = cfg.settings;
        keybindings = cfg.keybindings;
      };
    };

    home.packages = with pkgs; [ nil nixpkgs-fmt typst typstyle tinymist ];

    unfree.list = with pkgs;
      with pkgs.vscode-extensions.ms-vscode-remote; [
        vscode
        remote-ssh
        remote-ssh-edit
      ];
  };
}
