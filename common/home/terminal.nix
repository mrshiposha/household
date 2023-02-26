{ pkgs, ... }: with pkgs; {
  programs.alacritty = {
    enable = true;
    settings = {
      opacity = 0.75;
      colors = {
        backward = "#ffa500";
        foreground = "#a5c90f";
      };
    };
  };
}
