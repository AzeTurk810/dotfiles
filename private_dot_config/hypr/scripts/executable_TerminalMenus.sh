#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.config/hypr/scripts/menus"

# Find executable scripts
selected=$(
    find "$SCRIPT_DIR" -maxdepth 1 -type f -executable \
    | sed "s|$SCRIPT_DIR/||" \
    | sort \
    | fzf \
        --height=40% \
        --border \
        --layout=reverse \
        --prompt="Scripts > " \
        --preview="bat --style=plain --color=always '$SCRIPT_DIR/{}' 2>/dev/null || cat '$SCRIPT_DIR/{}'"
)

[ -z "$selected" ] && exit 0

"$SCRIPT_DIR/$selected"
