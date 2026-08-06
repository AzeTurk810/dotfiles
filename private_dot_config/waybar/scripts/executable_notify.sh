#!/usr/bin/env bash

if [ "$(swaync-client -D)" = "true" ]; then
    echo "󰂛"
else
    echo "󰂚"
fi
