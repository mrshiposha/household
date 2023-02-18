username: args @ { pkgs, lib, ... }:
let homenix = "/home/${username}/.config/nixpkgs/home.nix";
in {
  config = lib.mkMerge [
    {
      home.file."home.nix" = {
        target = homenix;
        text = ''args @ { pkgs, lib, ... }: with pkgs; {
          config = lib.mkMerge [
            (import /household-conf/common/home.nix ${username} args)
            {
              # Add your modifications here
            }
          ];
        }'';
      };
    }
    (import ./home.nix username args)
  ];
}
