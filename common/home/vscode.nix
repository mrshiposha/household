{ pkgs, ... }: with pkgs; {
  programs.vscode = {
    enable = true;
    package = vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bungcip.better-toml
      matklad.rust-analyzer
      vscode-extensions.jock.svg
    ] ++ vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nix-env-selector";
        publisher = "arrterian";
        version = "1.0.9";
        sha256 = "sha256-TkxqWZ8X+PAonzeXQ+sI9WI+XlqUHll7YyM7N9uErk0=";
      }

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

      {
        name = "markdown-preview-enhanced";
        publisher = "shd101wyy";
        version = "0.6.8";
        sha256 = "sha256-9NRaHgtyiZJ0ic6h1B01MWzYhDABAl3Jm2IUPogYWr0=";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "terminal.integrated.fontFamily" = "MesloLGS NF";
      "files.insertFinalNewline" = true;
      "nixEnvSelector.suggestion" = true;
    };
  };
}
