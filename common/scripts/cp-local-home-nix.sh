homenix=$HOME/.config/nixpkgs/home.nix
if [[ -L $homenix ]]; then
    location=$(readlink $homenix)
    if [[ $location =~ ^/nix/store/.*-household-conf/common/home.nix$ ]]; then
        cp --remove-destination $locaion $homenix
    fi
fi
