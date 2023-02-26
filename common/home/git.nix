{
  name,
  email
}: { pkgs, ... }: with pkgs; {
  programs.git = {
    enable = true;
    package = gitFull;
    userName = name;
    userEmail = email;
    extraConfig.credential.helper = "libsecret";
  };
}
