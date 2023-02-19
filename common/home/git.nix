name: email: { pkgs, ... }: with pkgs; {
  programs.git = {
    enable = true;
    extraConfig = {
      user.name = name;
      user.email = email;
    };
  };
}
