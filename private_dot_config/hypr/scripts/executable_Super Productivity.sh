#!/bin/bash

if pgrep -x Discord >/dev/null; then
    com.super_productivity.SuperProductivity &
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("productivity")'
else
    com.super_productivity.SuperProductivity &
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("productivity")'
fi
