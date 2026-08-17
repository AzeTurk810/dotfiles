normalize_wall() {
    local w="$1"
    [[ "$w" == WALLPAPER=* ]] && w="${w#WALLPAPER=}"
    printf "%s\n" "$w"
}
CURRENT_WALLPAPER=$(awww query | sed -n 's/.*image: //p')
CURRENT_WALLPAPER=$(normalize_wall "$CURRENT_WALLPAPER")
echo "$CURRENT_WALLPAPER"
