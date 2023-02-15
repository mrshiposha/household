#!/bin/sh

set -e

if [ -z "$1" ]
  then
    echo "No host is supplied to set up."
    exit 1
fi

if [ -z "$2" ]
  then
    rootdir=/
  else
    rootdir=$2
fi

host=$1

scriptdir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
ln -nsf $scriptdir $rootdir/etc/household-conf

hostconf=$rootdir/etc/household-conf/host/$host.nix

if [ ! -f $hostconf ]; then
    echo "There no such host '$host'"
    exit 2
fi

cat > $rootdir/etc/nixos/configuration.nix <<- EOM
args @ { config, pkgs, ... }: import $hostconf args
EOM
