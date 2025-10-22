{ nixosConfig, config, lib, pkgs, ... }:
with lib;
let cfg = config.preset.mrshiposha;
in {
  options.preset.mrshiposha = {
    enable = mkEnableOption "mrshiposha user";
    devEmail = mkEnableOption "dev email sender";
  };

  config = mkIf cfg.enable {
    preset.regularUser.enable = mkDefault true;

    yazi.enable = mkDefault true;
    helix.enable = mkDefault true;
    vscode.enable = mkDefault nixosConfig.gui.enable;
    logseq.enable = mkDefault false;
    connections = {
      mattermost.enable = mkDefault nixosConfig.gui.enable;
      matrix.enable = mkDefault nixosConfig.gui.enable;
    };

    firefox.addons =
      [ "polkadot-js-extension" "ether-metamask" "torproject-snowflake" ];

    programs = {
      zsh.initContent =
        "	function navigate() {\n		echo \"Navigating the fleet...\\n\" && sudo -u navigator $*\n	}\n";

      git = {
        enable = mkDefault true;
        package = pkgs.gitFull;
        userName = "Daniel Shiposha";
        userEmail = "dev@shiposha.com";
        extraConfig = { safe.directory = [ "/household" ]; };
      };

      lazygit.enable = true;

      direnv = {
        enable = mkDefault true;
        nix-direnv.enable = mkDefault true;
      };
    };

    accounts.email.accounts = mkIf cfg.devEmail {
      dev = {
        primary = true;
        realName = "Daniel Shiposha";
        address = "dev@shiposha.com";
        userName = "dev@shiposha.com";
        passwordCommand = "cat ${config.secrets.dev-email.secret.path}";

        aerc.enable = true;
        smtp = {
          host = "smtp.protonmail.ch";
          port = 587;
        };
      };
    };

    home.packages = with pkgs;
      mkMerge [
        (mkIf nixosConfig.gui.enable [ usbimager trilium-desktop ])
        [ coturn jq fx ]
      ];

    xdg.desktopEntries = {
      devWork = {
        name = "work dev session";
        comment = "initiate work dev session";
        categories = [ "Development" ];
        exec =
          "wezterm start --class org.wezfurlong.wezterm/dev -- hx /home/mrshiposha/dev/work";
      };
      devPersonal = {
        name = "personal dev session";
        comment = "initiate personal dev session";
        categories = [ "Development" ];
        exec =
          "wezterm start --class org.wezfurlong.wezterm/dev -- hx /home/mrshiposha/dev/personal";
      };
      household = {
        name = "household dev session";
        comment = "initiate household dev session";
        categories = [ "Development" ];
        exec =
          "wezterm start --class org.wezfurlong.wezterm/dev -- hx /household";
      };
    };
  };
}
