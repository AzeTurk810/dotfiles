#!/usr/bin/env bash

set -e

NVIM_CONFIG="$HOME/.config/nvim/init.lua"

list_themes() {
    echo "bro this is not working so good luck, just check at nvim can u run colorscheme command at command line?"
    nvim --headless -c 'lua for _, c in ipairs(vim.fn.getcompletion("", "color")) do print(c) end' -c 'q' 2>/dev/null
}

# Check if an argument was provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <theme>"
    echo ""
    echo "Available themes:"
    list_themes | sed 's/^/  - /'
    exit 0
fi

THEME="$1"
if  [[ $THEME == "kangawa" ]]; then 
    THEME="kanagawa"
fi

if  [[ $THEME == "tokyo-night" ]]; then 
    THEME="tokyonight-day"
fi

if  [[ $THEME == "emrald" ]]; then 
    THEME="emerald-synth"
fi

if ! nvim --headless -c "lua if not pcall(vim.cmd, 'colorscheme $THEME') then os.exit(1) end" -c 'q' >/dev/null 2>&1; then
    echo "Error: Theme '$THEME' is not installed or failed to load!"
    exit 0
fi
if grep -q "local theme =" "$NVIM_CONFIG" 2>/dev/null; then
    sed -i -E "s/local theme = [\"'][^\"']+[\"']/local theme = \"$THEME\"/g" "$NVIM_CONFIG"
else
    TMP_FILE=$(mktemp)
    echo "local theme = \"$THEME\"" >"$TMP_FILE"
    cat "$NVIM_CONFIG" >>"$TMP_FILE"
    mv "$TMP_FILE" "$NVIM_CONFIG"
fi

if grep -q "vim\.cmd\.colorscheme" "$NVIM_CONFIG" 2>/dev/null; then
    sed -i -E "s/vim\.cmd\.colorscheme\(.+\)/vim.cmd.colorscheme(theme)/g" "$NVIM_CONFIG"
else
    echo "" >>"$NVIM_CONFIG"
    echo "vim.cmd.colorscheme(theme)" >>"$NVIM_CONFIG"
fi

echo "Successfully updated theme to '$THEME' in $NVIM_CONFIG"
sleep 0.2
