{ pkgs, ... }: with pkgs; {
  programs.vscode = {
    enable = true;
    package = vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscode-extensions.matklad.rust-analyzer
      vscode-extensions.bungcip.better-toml
    ] ++ vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "yuck";
        publisher = "eww-yuck";
        version = "0.0.3";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      }
    ];
    userSettings = {
      "terminal.integrated.fontFamily" = "MesloLGS NF";
    };
  };
}
