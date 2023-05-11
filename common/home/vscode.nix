{ pkgs, ... }: with pkgs; {
  programs.vscode = {
    enable = true;
    package = vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bungcip.better-toml
      matklad.rust-analyzer
      vadimcn.vscode-lldb
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

      {
        name = "agda-mode";
        publisher = "banacorn";
        version = "0.3.11";
        sha256 = "sha256-jnH3oNqvkO/+Oi+8MM1RqooPFrQZMDWLSEnrVLnc5VI=";
      }

      {
        name = "sabye";
        publisher = "izcream";
        version = "0.1.42";
        sha256 = "sha256-w757yGHq0jBDb7IdS0wkD8PIHlKt73VLuzpdgy3mlM8=";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "terminal.integrated.fontFamily" = "MesloLGS NF";
      "files.insertFinalNewline" = true;
      "nixEnvSelector.suggestion" = true;
      "lldb.suppressUpdateNotifications" = true;
      "editor.unicodeHighlight.ambiguousCharacters" = false;
      "editor.fontFamily" = "Noto Sans Math";
      "editor.fontSize" = 18;
      "workbench.colorTheme" = "sabye";
    };
  };

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}
