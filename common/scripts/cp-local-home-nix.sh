#!/bin/sh

location=$1
homenix=$HOME/.config/nixpkgs/home.nix

cp-home-nix() {
    cp --remove-destination $location $homenix
}

if [[ ! -f $homenix ]]; then
    cp-home-nix
fi

if [[ -L $homenix ]]; then
    linktarget=$(readlink $homenix)
    if [[ $linktarget == $location ]]; then
        cp-home-nix
    fi
fi
