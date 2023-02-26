{
  name,
  email
}: { pkgs, ... }: with pkgs; {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
  };
}
