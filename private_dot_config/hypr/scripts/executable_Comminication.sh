#!/bin/bash

if pgrep -x Discord >/dev/null; then
    discord &
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("communication")'
else
    discord &
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("communication")'
fi
