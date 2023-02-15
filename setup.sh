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
confdir=$rootdir/household-conf

hostconf=$confdir/host/$host.nix

if [ ! -f $hostconf ]; then
    echo "There no such host '$host'"
    exit 2
fi

cat > $rootdir/etc/nixos/configuration.nix <<- EOM
args @ { config, pkgs, ... }: import $hostconf args
EOM
