#!/bin/bash

player=$(playerctl -l | fzf --prompt="Select Player > ") || exit

while true; do
    clear
    playerctl -p "$player" metadata --format "{{artist}} - {{title}}"
    echo
    cover=$(playerctl -p "$player" metadata mpris:artUrl)
    if [[ $cover == data:image/* ]]; then
        ext=$(echo "$cover" | sed -E 's|data:image/([^;]+);base64,.*|\1|')
        file="/tmp/cover.$ext"

        echo "${cover#*,}" | base64 -d >"$file"

        kitty +kitten icat "$file"
    fi
    echo "[p] Play/Pause"
    echo "[n] Next"
    echo "[b] Previous"
    echo "[q] Quit"
    notify-send \
        "$(playerctl -p "$player" metadata xesam:title)" \
        "$(playerctl -p "$player" metadata xesam:artist)"

    read -rn1 key

    case "$key" in
    p)
        playerctl -p "$player" play-pause
        sleep 0.2
        ;;
    n)
        playerctl -p "$player" next
        sleep 0.2
        ;;
    b)
        playerctl -p "$player" previous
        sleep 0.2
        ;;
    q) break ;;
    esac
done
