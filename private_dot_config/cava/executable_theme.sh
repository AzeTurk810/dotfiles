#!/usr/bin/env bash

set -e

CAVA_CONFIG="$HOME/.config/cava/colors"
THEME_DIR="$HOME/.config/cava/themes"

list_themes() {
    # TODO: Implement list themes
    # echo "i don't have time + i don't know how: TODO"
    ls "$THEME_DIR"
}

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <theme>"
    echo ""
    echo "Available themes:"
    list_themes | sed 's/^/  - /'
    exit 0
fi

THEME="$1"

if [[ "$THEME" == "tokyo-night" ]]; then
    THEME="tokyonight"
fi
SRC="$THEME_DIR/$THEME"
if [[ ! -f "$SRC" ]]; then
    echo "Theme '$1' not found."
    echo
    echo "themes:"
    list_themes
    exit 0
fi

cp "$SRC" "$CAVA_CONFIG"

echo "Successfully updated theme to '$THEME' in $CAVA_CONFIG"
sleep 0.2

