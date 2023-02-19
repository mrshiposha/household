name: email: { pkgs, ... }: with pkgs; {
  programs.git.config = {
    user.name = name;
    user.email = email;
  };
}
