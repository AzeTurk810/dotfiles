#!/bin/bash

if hyprctl clients | grep -Fq "(special:communication)"; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("communication")'
else
    discord &
    # kitty --class endcord -e endcord &
    # sleep 0.3
    # hyprctl dispatch 'hl.dsp.workspace.toggle_special("communication")'
fi
