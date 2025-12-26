#!/usr/bin/env bash
# SUPER WALLPAPER SELECTOR — PAGINATED + SEARCH ALL
set -euo pipefail

### ================= CONFIG =================
wallDIR="$HOME/Pictures/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
rofi_theme="$HOME/.config/rofi/config-wallpaper.rasi"

PAGE_SIZE=100

FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

CACHE_GIF="$HOME/.cache/gif_preview"
CACHE_VID="$HOME/.cache/video_preview"
mkdir -p "$CACHE_GIF" "$CACHE_VID"

### ================= ROFI (ARRAY FIX) =================
rofi_command=(
  rofi
  -i
  -show
  -dmenu
  -config "$rofi_theme"
)

### ================= MONITOR =================
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

### ================= WALLPAPER DAEMONS =================
kill_image() {
  pkill mpvpaper 2>/dev/null || true
  pkill swaybg 2>/dev/null || true
  pkill hyprpaper 2>/dev/null || true
}
kill_video() {
  swww kill 2>/dev/null || true
  pkill mpvpaper 2>/dev/null || true
}

### ================= APPLY =================
apply_image() {
  kill_image
  pgrep -x swww-daemon >/dev/null || swww-daemon --format xrgb &
  swww img -o "$focused_monitor" "$1" $SWWW_PARAMS
  "$SCRIPTSDIR/WallustSwww.sh" 2>/dev/null || true
}

apply_video() {
  kill_video
  mpvpaper '*' -o "no-audio loop" "$1" &
}

### ================= LOAD FILES =================
mapfile -t ALL < <(
  find "$wallDIR" -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o \
    -iname "*.gif" -o -iname "*.bmp" -o -iname "*.mp4" -o -iname "*.mkv" -o \
    -iname "*.mov" -o -iname "*.webm" \
  \) | sort
)

TOTAL=${#ALL[@]}
(( TOTAL == 0 )) && exit 1
PAGES=$(( (TOTAL + PAGE_SIZE - 1) / PAGE_SIZE ))
page=0

### ================= PREVIEW =================
preview() {
  local f="$1" n ext
  n=$(basename "$f")
  ext="${n##*.}"

  case "$ext" in
    gif)
      out="$CACHE_GIF/$n.png"
      [[ -f "$out" ]] || magick "$f[0]" -resize 512x512 "$out" 2>/dev/null
      echo -e "$n\x00icon\x1f$out"
      ;;
    mp4|mkv|mov|webm)
      out="$CACHE_VID/$n.png"
      [[ -f "$out" ]] || ffmpeg -y -loglevel error -ss 1 -i "$f" -vframes 1 "$out"
      echo -e "$n\x00icon\x1f$out"
      ;;
    *)
      echo -e "$(basename "$f" | sed 's/\.[^.]*$//')\x00icon\x1f$f"
      ;;
  esac
}

### ================= MENU LOOP =================
while true; do
  start=$(( page * PAGE_SIZE ))
  end=$(( start + PAGE_SIZE ))
  MENU=$(mktemp)

  {
    echo "Page $((page+1)) / $PAGES"
    for ((i=start; i<end && i<TOTAL; i++)); do
      preview "${ALL[i]}"
    done
    echo "⏮ Prev Page"
    echo "⏭ Next Page"
    echo "🔍 Search All"
    echo "❌ Quit"
  } > "$MENU"

  choice=$("${rofi_command[@]}" < "$MENU")
  rm -f "$MENU"

  [[ -z "$choice" ]] && exit 0

  case "$choice" in
    "⏭ Next Page") page=$(( (page+1) % PAGES )); continue ;;
    "⏮ Prev Page") page=$(( (page-1+PAGES) % PAGES )); continue ;;
    "❌ Quit") exit 0 ;;
    "🔍 Search All")
      query=$(printf "" | "${rofi_command[@]}" -p "Search:")
      [[ -z "$query" ]] && continue
      mapfile -t RESULTS < <(printf "%s\n" "${ALL[@]}" | grep -i "$query")
      [[ ${#RESULTS[@]} -eq 0 ]] && continue

      TMP=$(mktemp)
      for f in "${RESULTS[@]}"; do preview "$f"; done > "$TMP"
      sel=$("${rofi_command[@]}" < "$TMP")
      rm -f "$TMP"
      [[ -z "$sel" ]] && continue
      file=$(printf "%s\n" "${RESULTS[@]}" | grep -i "$(basename "$sel" | cut -d. -f1)" | head -n1)
      ;;
    *)
      file=$(printf "%s\n" "${ALL[@]}" | grep -i "$(basename "$choice" | cut -d. -f1)" | head -n1)
      ;;
  esac

  [[ -z "${file:-}" ]] && continue

  case "$file" in
    *.mp4|*.mkv|*.mov|*.webm) apply_video "$file" ;;
    *) apply_image "$file" ;;
  esac

  exit 0
done

