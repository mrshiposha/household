#!/bin/sh

homenix=$HOME/.config/nixpkgs/home.nix

if [[ -L $homenix ]]; then
    linktarget=$(readlink $homenix)
    if [[ $linktarget =~ ^/nix/store/.*-home-manager-files/\.config/nixpkgs/home\.nix$ ]]; then
        cp --remove-destination $linktarget $homenix
    fi
fi
