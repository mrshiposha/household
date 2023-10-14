{ common }: { pkgs, ... }: with pkgs; {
  programs.alacritty = {
    enable = true;
    settings = {
      import = ["${common}/home/.config/alacritty/theme"];
    };
  };
  home.sessionVariables = {
    TERM = "alacritty";
    TERMINAL = "alacritty";
  };
}
