name: email: { pkgs, ... }: with pkgs; {
  programs.git.extraConfig = {
    user.name = name;
    user.email = email;
  };
}
