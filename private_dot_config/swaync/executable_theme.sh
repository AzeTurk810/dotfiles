#!/usr/bin/env bash

set -e

THEME_DIR="$HOME/.config/swaync/themes"
DEST="$HOME/.config/swaync/style.css"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <theme>"
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.css$//'
    exit 0
fi

THEME="$1"
[[ "$THEME" == "gruvbox-material" ]] && THEME="gruvbox"
if [[ "$THEME" == "kangawa" ]]; then
    THEME="kanagawa"
fi

[[ "$THEME" == "rose-pine-dawn" ]] && THEME="rosepine-dawn"
[[ "$THEME" == "rose-pine" ]] && THEME="rosepine"

if [[ "$THEME" == "emrald" ]]; then
    THEME="emerald"
fi

SRC="$THEME_DIR/$THEME.css"

if [[ ! -f "$SRC" ]]; then
    echo "Theme '$1' not found."
    echo
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.css$//'
    exit 0
fi

cp "$SRC" "$DEST"

echo "Applied theme: $1 to sway"
swaync-client -rs

