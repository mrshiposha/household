{ pkgs, ... }: with pkgs; {
  programs.vscode = {
    enable = true;
    package = vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscode-extensions.matklad.rust-analyzer
      vscode-extensions.bungcip.better-toml
    ];
    userSettings = {
      "terminal.integrated.fontFamily" = "MesloLGS NF";
    };
  };
}
