{ pkgs, ... }: with pkgs; {
  programs.firefox = {
    enable = true;
  };
}
