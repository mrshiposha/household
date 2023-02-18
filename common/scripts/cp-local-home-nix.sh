#!/bin/sh

homenix=$HOME/.config/nixpkgs/home.nix
if [[ -L $homenix ]]; then
    location=$(readlink $homenix)
    if [[ $location =~ ^/nix/store/.*-home-manager-files/\.config/nixpkgs/home\.nix$ ]]; then
        cp --remove-destination $location $homenix
    fi
fi
