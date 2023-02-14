{ config, pkgs, ... }: with pkgs; {
  users.defaultUserShell = zsh;
  environment.shells = [ zsh ];
}
