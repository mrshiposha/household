{ config, pkgs, household, ... }:
let uid = 1010; in
{
  users.users.navigator = {
    description = "fleet navigator";
    isNormalUser = true;
    inherit uid;
    group = "wheel";
    shell = pkgs.zsh;
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINtzZVQaPQiYzzuV8ZKdQ7mCXV1uug652EKJRdXpj+ZE navigator@shiposha.com"
    ];
  };
  security.sudo.extraConfig = ''
    navigator ALL=(ALL) NOPASSWD:ALL
  '';
  home-manager.users.navigator = {
    imports = [ household.modules.user ];

    home.stateVersion = config.system.stateVersion;
    zsh.enable = true;
    programs = {
      git.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
