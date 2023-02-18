let system-version = import ../system-version.nix;
in let home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system-version}.tar.gz";
in import "${home-manager}/nixos"
