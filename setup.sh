#!/bin/sh

if [ -z "$1" ]
  then
    echo "No host is supplied to set up."
    exit 1
fi

host=$1

scriptdir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
ln -s $scriptdir /etc/household-conf

hostconf=/etc/household-conf/host/$host.nix

if [ ! -f $hostconf ]; then
    echo "There no such host '$host'"
    exit 2
fi

cat > /etc/nixos/configuration.nix <<- EOM
{ config, pkgs, ... }: {
    imports = [ /etc/household-conf/host/$conf.nix ];
}
EOM
