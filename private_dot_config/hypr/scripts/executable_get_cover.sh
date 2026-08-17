#!/usr/bin/env bash

COVER_TMP="/tmp/hyprlock-art.png"
FALLBACK_PIC="$HOME/.config/hypr/vivek.png"

# Get mpris artUrl
art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)

if [ -z "$art_url" ]; then
    # No music playing -> use fallback
    cp "$FALLBACK_PIC" "$COVER_TMP"
    echo "$COVER_TMP"
    exit 0
fi
echo "$art_url"

# If art is a local file (file://...)
if [[ "$art_url" == file://* ]]; then
    img_path="${art_url#file://}"
    cp "$img_path" "$COVER_TMP"
# If art is an HTTP image URL (Spotify, Web Players, etc.)
elif [[ "$art_url" == http://* || "$art_url" == https://* ]]; then
    curl -s "$art_url" --output "$COVER_TMP"
else
    cp "$FALLBACK_PIC" "$COVER_TMP"
fi

echo "$COVER_TMP"
