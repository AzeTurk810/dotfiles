#!/usr/bin/env bash

TEMP=3500

if pgrep -x gammastep >/dev/null; then
    pkill -x gammastep
else
    gammastep -O "$TEMP" >/dev/null 2>&1 &
    disown
fi
