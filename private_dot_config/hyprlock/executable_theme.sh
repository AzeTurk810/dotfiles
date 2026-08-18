#!/usr/bin/env bash

set -e
HYPR_DIR="$HOME/.config/hypr"
HYPRLOCK_DIR="$HOME/.config/hyprlock"

list_themes() {
    ls "$HYPRLOCK_DIR"
}

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <theme>"
    echo ""
    echo "Available themes:"
    list_themes
    exit 0
fi

THEME=$1

[[ "$THEME" == "kangawa" ]] && THEME="kanagawa"
[[ "$THEME" == "emrald" ]] && THEME="emerald"
THEME_DIR="$HYPRLOCK_DIR/$THEME"

if [[ ! -d "$THEME_DIR" ]]; then
    echo "Theme '$THEME' not found."
    echo
    # echo "Available themes:"
    # list_themes
    echo "Changing to Universall"
    THEME="universal"
    THEME_DIR="$HYPRLOCK_DIR/$THEME"
fi

cp "$HYPRLOCK_DIR/$THEME"/. -r "$HYPR_DIR"
echo "Hyprlock theme changed to: $THEME"
sleep 0.2
