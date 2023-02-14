#!/bin/sh

if [ -z "$1" ]
  then
    echo "No host is supplied to set up."
fi

conf=$1

scriptdir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
ln -s $scriptdir /etc/household-conf

cat > /etc/nixos/configuration.nix <<- EOM
{ config, pkgs, ... }: {
    imports = [ /etc/household-conf/host/$conf.nix ];
}
EOM
