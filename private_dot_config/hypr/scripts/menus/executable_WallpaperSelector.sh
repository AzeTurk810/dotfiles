#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers"

wallpaper=$(
    find "$WALLDIR" -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) |
    fzf \
        --height=100% \
        --layout=reverse \
        --preview='kitty +kitten icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {}' \
        --preview-window=right:60%
)

[[ -z "$wallpaper" ]] && exit

monitor=$(hyprctl monitors -j | jq -r '.[].name' | fzf --prompt="Monitor > ")
[[ -z "$monitor" ]] && exit

awww img "$wallpaper" \
    --outputs "$monitor" \
    --transition-type grow \
    --transition-fps 60 \
    --transition-duration 1
