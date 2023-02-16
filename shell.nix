{ config, pkgs, ... }: with pkgs; {
  users.defaultUserShell = zsh;
  environment.shells = [ zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };
}
