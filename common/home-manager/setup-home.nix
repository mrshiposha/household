username: args @ { pkgs, ... }:
let homenix = "/home/${username}/.config/nixpkgs/home.nix";
in (import /household-conf/common/home.nix username args) {
  home.file."${homenix}" = {
    enable = !pathExists homenix;
    text = ''args @ { pkgs, ... }: with pkgs; 
(import /household-conf/common/home.nix ${username} args) // {
  # Add you modifications here
}'';
  };
}
