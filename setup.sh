#!/bin/sh

scriptdir=$(dirname "$0")

mkdir /etc/household-conf
ln -s $scriptdir /etc/household-conf
