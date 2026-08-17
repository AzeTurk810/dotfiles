#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/.config/idk"
CURRENT_THEME_FILE="$CONFIG_DIR/current_theme"
WAYBAR_THEME="$HOME/.config/waybar/theme.sh"
KITTY_THEME="$HOME/.config/kitty/theme.sh"
NVIM_THEME="$HOME/.config/nvim/theme.sh"
CAVA_THEME="$HOME/.config/cava/theme.sh"
SWAY_THEME="$HOME/.config/swaync/theme.sh"
HYPRLOCK_THEME="$HOME/.config/hyprlock/theme.sh"
BTOP_THEME="$HOME/.config/btop/theme.sh"
# WARNING: You must change it to your obsidian voult's location...
OBSIDIAN_THEME="$HOME/Documents/Apps/Obsidian/AzeTurk810/.obsidian/theme.sh" 

mkdir -p "$CONFIG_DIR"

transitions=(
    simple
    fade
    left
    right
    top
    bottom
    wipe
    wave
    grow
    center
    outer
    any
)

########################################
# Helpers
########################################

normalize_wall() {
    local w="$1"
    [[ "$w" == WALLPAPER=* ]] && w="${w#WALLPAPER=}"
    printf "%s\n" "$w"
}

save_wallpaper() {
    # echo "CURRENT_THEME='$CURRENT_THEME'"
    # echo "CURRENT_WALLPAPER='$CURRENT_WALLPAPER'"
    # echo "Saving to: $CONFIG_DIR/$CURRENT_THEME.conf"
    # sleep 0.5
    local theme="$1"
    local wall="$2"

    [[ -z "$theme" || -z "$wall" ]] && return

    wall=$(normalize_wall "$wall")

    local conf="$CONFIG_DIR/$theme.conf"

    touch "$conf"

    {
        echo "$wall"
        sed 's/^WALLPAPER=//' "$conf" 2>/dev/null | grep -Fxv "$wall" || true
    } >"$conf.tmp"

    mv "$conf.tmp" "$conf"
}

apply_wallpaper() {
    local wall
    wall=$(normalize_wall "$1")

    [[ ! -f "$wall" ]] && {
        echo "Wallpaper not found:"
        echo "$wall"
        exit 1
    }

    local transition=${transitions[$RANDOM % ${#transitions[@]}]}

    awww img "$wall" \
        --transition-type "$transition" \
        --transition-duration 1.2
}

########################################
# Current theme
########################################

CURRENT_THEME=""

if [[ -f "$CURRENT_THEME_FILE" ]]; then
    CURRENT_THEME=$(<"$CURRENT_THEME_FILE")
fi

CURRENT_WALLPAPER=$(awww query | sed -n 's/.*image: //p')
CURRENT_WALLPAPER=$(normalize_wall "$CURRENT_WALLPAPER")

########################################
# Menu
########################################

if [[ $# -ge 1 ]]; then
    ACTION="$1"
else
    ACTION=$(
        {
            find "$CONFIG_DIR" -maxdepth 1 -name "*.conf" \
                -printf "%f\n" |
                sed 's/\.conf$//' |
                sort
            echo "────────────"
            echo "currentW"
            echo "deleteW"
            echo "yellow-motor"
        } | fzf --prompt="Theme > " --border
    ) || exit 0

    [[ "$ACTION" == "────────────" ]] && exit 0
fi

########################################
# currentW
########################################

if [[ "$ACTION" == "currentW" ]]; then

    CONF="$CONFIG_DIR/$CURRENT_THEME.conf"

    [[ ! -f "$CONF" ]] && {
        echo "No wallpapers saved."
        exit 1
    }

    WALL=$(
        sed 's/^WALLPAPER=//' "$CONF" | fzf --prompt="Wallpaper > "
    ) || exit 0

    apply_wallpaper "$WALL"

    {
        echo "$WALL"
        sed 's/^WALLPAPER=//' "$CONF" | grep -Fxv "$WALL"
    } >"$CONF.tmp"

    mv "$CONF.tmp" "$CONF"

    echo "Applied wallpaper."

    exit 0
fi

########################################
# deleteW
########################################

if [[ "$ACTION" == "deleteW" ]]; then

    CONF="$CONFIG_DIR/$CURRENT_THEME.conf"

    [[ ! -f "$CONF" ]] && {
        echo "No wallpapers saved."
        exit 1
    }

    WALL=$(
        sed 's/^WALLPAPER=//' "$CONF" | fzf --prompt="Delete wallpaper > "
    ) || exit 0

    grep -Fxv "$WALL" <(sed 's/^WALLPAPER=//' "$CONF") >"$CONF.tmp"

    mv "$CONF.tmp" "$CONF"

    echo "Deleted:"
    echo "$WALL"

    exit 0
fi

########################################
# Themes scpecial (lowkey no english)
########################################

# Yellow motor yamaha
if [[ "$ACTION" == "yellow-motor" ]]; then
    nohup bash "$HOME/.config/themes/mpvpaper-yellow-motor.sh" >/dev/null 2>&1 &
    nohup bash "$HOME/.config/themes/yellow-motor.sh" >/dev/null 2>&1 &
    sleep 0.5
    exit 0
fi

########################################
# Switch theme
########################################

# pkill -9 mpvpaper
NEW_THEME="$ACTION"

# Save current wallpaper to current theme
if [[ -n "$CURRENT_THEME" && -n "$CURRENT_WALLPAPER" ]]; then
    save_wallpaper "$CURRENT_THEME" "$CURRENT_WALLPAPER"
fi

CONF="$CONFIG_DIR/$NEW_THEME.conf"

if [[ -f "$CONF" ]]; then
    WALL=$(head -n1 "$CONF")
    WALL=$(normalize_wall "$WALL")

    [[ -n "$WALL" ]] && apply_wallpaper "$WALL"
fi

echo "$NEW_THEME" >"$CURRENT_THEME_FILE"

echo "Waybar: "
echo
"$WAYBAR_THEME" "$NEW_THEME"
echo "Kitty: "
echo
"$KITTY_THEME" "$NEW_THEME"
echo "Nvim: "
echo
"$NVIM_THEME" "$NEW_THEME"
echo "Cava: "
echo
"$CAVA_THEME" "$NEW_THEME"
echo "Sway: "
echo
"$SWAY_THEME" "$NEW_THEME"
echo "Hyprlock: "
echo
"$HYPRLOCK_THEME" "$NEW_THEME"
echo "Btop:"
echo
"$BTOP_THEME" "$NEW_THEME"
echo "Obsidian: "
echo
"$OBSIDIAN_THEME" "$NEW_THEME"


notify-send "Swiched theme to $NEW_THEME"
echo "Switched to $NEW_THEME"
echo "Press any key to continue..."
read -n 1 -s -r
