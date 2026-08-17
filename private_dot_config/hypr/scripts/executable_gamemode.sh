#!/usr/bin/env sh

STATE=$(hyprctl getoption animations:enabled | awk '/bool:/ {print $2}')

if [ "$STATE" = "true" ]; then
    hyprctl --batch "\
        keyword animations:enabled false;\
        keyword decoration:shadow:enabled false;\
        keyword decoration:blur:enabled false;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"

    notify-send "🎮 Game Mode" "Enabled"
else
    hyprctl reload
    notify-send "🖥️ Normal Mode" "Restored"
fi
