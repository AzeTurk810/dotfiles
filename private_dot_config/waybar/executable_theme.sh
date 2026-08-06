#!/usr/bin/env bash

set -e

THEME_DIR="$HOME/.config/waybar/themes"
DEST="$HOME/.config/waybar/theme.css"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <theme>"
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.css$//'
    exit 1
fi

SRC="$THEME_DIR/$1.css"

if [[ ! -f "$SRC" ]]; then
    echo "Theme '$1' not found."
    echo
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.css$//'
    exit 1
fi

cp "$SRC" "$DEST"

echo "Applied theme: $1"
