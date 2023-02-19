common-home: username: stateVersion: { pkgs, ... }: with pkgs; {
  imports = [
    (import "${common-home}/base.nix" username stateVersion)
    (import "${common-home}/git.nix" username "${userhome}@gmail.com")
  ];
}
