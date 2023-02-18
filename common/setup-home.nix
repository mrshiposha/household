username: args @ { pkgs, lib, ... }:
let homenix = "/home/${username}/.config/nixpkgs/home.nix";
in {
  config = lib.mkMerge [
    {
      home.file."home.nix" = {
        enable = !builtins.pathExists homenix;
        target = homenix;
        text = ''args @ { pkgs, ... }: with pkgs; 
        (import /household-conf/common/home.nix ${username} args) // {
          # Add you modifications here
        }'';
      };
    }
    (import ./home.nix username args)
  ];
}
