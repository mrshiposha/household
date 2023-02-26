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
        sha256 = "DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
      }

      {
        name = "vscode-parinfer";
        publisher = "shaunlebron";
        version = "0.6.2";
        sha256 = "DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
      }
    ];
    userSettings = {
      "terminal.integrated.fontFamily" = "MesloLGS NF";
    };
  };
}
