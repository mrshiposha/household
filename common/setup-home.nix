username: args @ { pkgs, lib, ... }:
let homenix = "/home/${username}/.config/nixpkgs/home.nix";
in {
  config = lib.mkMerge [
    {
      home.file."home.nix" = {
        target = homenix;
        text = ''args @ { pkgs, lib, ... }: with pkgs; {
          config = lib.mkMerge [
            (import /household-conf/common/home.nix "${username}" args)
            {
              # NOTE: You can copy this file from the nix store to ~/.config/nixpkgs/home.nix
              # and add your modifications here.
              # E.g., programs.htop.enable = true;
            }
          ];
        }'';
      };
    }
    (import ./home.nix username args)
  ];
}
