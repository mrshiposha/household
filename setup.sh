#!/bin/sh

set -e

if [ -z "$1" ]
  then
    echo "No host is supplied to set up."
    exit 1
fi

if [ -z "$2" ]
  then
    rootdir=
  else
    rootdir=$2
fi

host=$1

hostconf=host/$host/configuration.nix

if [ ! -f $rootdir/household-conf/$hostconf ]; then
    echo "There no such host '$host'"
    exit 2
fi

systemver=$(cat common/system-version.nix | sed 's/"//g')

mkdir -p $rootdir/etc/nixos

cat > $rootdir/etc/nixos/configuration.nix <<- EOM
{
    imports = [
        ../../household-conf/$hostconf
        ./hardware-configuration.nix
    ];
}
EOM
