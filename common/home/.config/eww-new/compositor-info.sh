#!/usr/bin/env bash

PWD=$(dirname "$0")

swaymsg -mt subscribe '["workspace", "window"]' \
    | jq --unbuffered -c -f $PWD/acceptable-change.jq \
    | while read _; do swaymsg -t get_tree; done \
    | jq --unbuffered -c -f $PWD/compositor-info.jq
