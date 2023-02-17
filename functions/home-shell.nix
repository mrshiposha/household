{ pkgs, ... }: with pkgs; {
  fonts.fontconfig.enable = true;
  home.packages = [meslo-lgs-nf];
  programs.zsh = {
    enable = true;
    plugins = [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
    ];
  };
}
