username: { pkgs, ... }: with pkgs; {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = import ../system-version.nix;

  fonts.fontconfig.enable = true;
  home.packages = [meslo-lgs-nf];
  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      plugins = [
        {
          file = "powerlevel10k.zsh-theme";
          name = "powerlevel10k";
          src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
        }
      ];
      initExtra = ''
        source ~/.p10k.zsh
      '';
    };
  };
}
