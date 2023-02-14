#!/bin/sh

conf=$1

scriptdir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
ln -s $scriptdir /etc/household-conf

cat > /etc/configuration.nix <<- EOM
{ config, pkgs, ... }: {
    imports = [ /etc/household-conf/host/$conf.nix ];
}
EOM
