pkgs:
  with pkgs.vscode-extensions; [
    tamasfe.even-better-toml
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    dbaeumer.vscode-eslint
    jnoortheen.nix-ide
    myriad-dreamin.tinymist
    vscodevim.vim
    mkhl.direnv
    tauri-apps.tauri-vscode
  ]
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "nord-visual-studio-code";
    publisher = "arcticicestudio";
    version = "0.19.0";
    sha256 = "sha256-awbqFv6YuYI0tzM/QbHRTUl4B2vNUdy52F4nPmv+dRU=";
  }

  {
    name = "markdown-preview-enhanced";
    publisher = "shd101wyy";
    version = "0.6.8";
    sha256 = "sha256-9NRaHgtyiZJ0ic6h1B01MWzYhDABAl3Jm2IUPogYWr0=";
  }

  {
    name = "jsonnet";
    publisher = "heptio";
    version = "0.1.0";
    sha256 = "sha256-AwiVkUNyKTTCzzsS0XoQRFeW/e+iOsXxeLANi8/kEdQ=";
  }

  {
    name = "rainbow-bracket";
    publisher = "tal7aouy";
    version = "1.0.2";
    sha256 = "sha256-H0J9ZhzHpJ96fW7DrVqpA9tqAgL2cFmM9Wu9STu1MUY=";
  }

  {
    name = "scheme";
    publisher = "jeandeaual";
    version = "0.2.0";
    sha256 = "sha256-ddehU7YeHv62QjZiTk0HV9wHgz8mVDuyMpH/w89bh6s=";
  }

  {
    name = "language-x86-64-assembly";
    publisher = "13xforever";
    version = "3.1.4";
    sha256 = "sha256-FJRDm1H3GLBfSKBSFgVspCjByy9m+j9OStlU+/pMfs8=";
  }
]
