{ pkgs, ... }: with pkgs; {
  programs.vscode = {
    enable = true;
    package = vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      matklad.rust-analyzer
      bungcip.better-toml
      shd101wyy.markdown-preview-enhanced
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
        sha256 = "zev0oomPf9B+TaNRnp4xcmEWJBaa+IHgysbX2G0mm0A=";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "terminal.integrated.fontFamily" = "MesloLGS NF";
      "files.insertFinalNewline" = true;
    };
  };
}
