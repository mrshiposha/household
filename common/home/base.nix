{
  common,
  username,
  stateVersion
}: { pkgs, ... }: with pkgs;
let
  p10k-normal = "${common}/home/p10k/normal.zsh";
  p10k-minimal = "${common}/home/p10k/minimal.zsh";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = stateVersion;

  home.packages = [meslo-lgs-nf];
  fonts.fontconfig.enable = true;
  programs = {
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
        if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
          source ${p10k-normal}
        else
          source ${p10k-minimal}
        fi
      '';
    };
  };
}
