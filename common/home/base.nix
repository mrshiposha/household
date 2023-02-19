username: stateVersion: { pkgs, ... }: with pkgs; {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = stateVersion;

  home.packages = [meslo-lgs-nf];
  fonts.fontconfig.enable = true;
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
