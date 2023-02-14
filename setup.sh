#!/bin/sh

scriptdir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
ln -s $scriptdir /etc/household-conf
