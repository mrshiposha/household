#!/bin/sh

set -e

if [ -z "$1" ]
  then
    echo "No host is supplied to set up."
    exit 1
fi

host=/household-conf/host/$1

git config --system --add safe.directory /household-conf
chown -R $(cat $host/household-owner):wheel /household-conf
