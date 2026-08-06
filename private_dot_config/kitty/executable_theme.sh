#!/usr/bin/env bash

set -e

THEME_DIR="$HOME/.config/kitty/themes"
DEST="$HOME/.config/kitty/style.conf"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <theme>"
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.css$//'
    exit 1
fi

SRC="$THEME_DIR/$1.conf"

if [[ ! -f "$SRC" ]]; then
    echo "Theme '$1' not found."
    echo
    echo "Available themes:"
    ls "$THEME_DIR" | sed 's/\.conf$//'
    exit 0
fi

cp "$SRC" "$DEST"

echo "Applied theme: $1"

