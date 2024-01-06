{ pkgs, ... }: with pkgs; {
  programs.vscode = {
    enable = true;
    package = vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      tamasfe.even-better-toml
      matklad.rust-analyzer
      vadimcn.vscode-lldb
      jock.svg
      dbaeumer.vscode-eslint
      ms-vscode.hexeditor
      jnoortheen.nix-ide
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
        name = "jq-syntax-highlighting";
        publisher = "jq-syntax-highlighting";
        version = "0.0.2";
        sha256 = "sha256-Bwq+aZuDmzjHw+ZnIWlL4aGz6UnqxaKm5WUko0yuIWE=";
      }

      {
        name = "jsonnet-format";
        publisher = "itspngu";
        version = "0.4.0";
        sha256 = "sha256-ZfEwVt1xXAgF0nmqStC5hi8KY2cBjeqRSgTCskHuq4I=";
      }

      {
        name = "jsonnet";
        publisher = "heptio";
        version = "0.1.0";
        sha256 = "sha256-AwiVkUNyKTTCzzsS0XoQRFeW/e+iOsXxeLANi8/kEdQ=";
      }

      {
        name = "language-x86-64-assembly";
        publisher = "13xforever";
        version = "3.1.4";
        sha256 = "sha256-FJRDm1H3GLBfSKBSFgVspCjByy9m+j9OStlU+/pMfs8=";
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
        version = "0.4.1";
        sha256 = "sha256-jnH3oNqvkO/+Oi+8MM1RqooPFrQZMDWLSEnrVLnc5VI=";
      }

      {
        name = "agda";
        publisher = "j-mueller";
        version = "0.1.7";
        sha256 = "sha256-S0svSulHJKN7JwznVj3KTLd341oeMainUiY/peQdPSY=";
      }

      {
        name = "nord-visual-studio-code";
        publisher = "arcticicestudio";
        version = "0.19.0";
        sha256 = "sha256-awbqFv6YuYI0tzM/QbHRTUl4B2vNUdy52F4nPmv+dRU=";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "terminal.integrated.fontFamily" = "MesloLGS NF";
      "files.insertFinalNewline" = true;
      "nixEnvSelector.suggestion" = false;
      "lldb.suppressUpdateNotifications" = true;
      "editor.unicodeHighlight.ambiguousCharacters" = false;
      "editor.fontFamily" = "mononoki, Cambria Math";
      "editor.fontSize" = 18;
      "workbench.colorTheme" = "Nord";

      nix = {
        enableLanguageServer = true;
        serverPath = "nixd";
      };
    };
  };

  home.packages = [
    nixd
  ];

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}
