{ pkgs, ... }: with pkgs; {
  users.defaultUserShell = zsh;
  environment.shells = [ zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;

    shellInit = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';

    interactiveShellInit = ''
      system-rebuild() {
        sudo VPN_SERVER_KEY=$(pass show vpn/server-key) nixos-rebuild "$@"
      }
    '';
  };
}
