#!/bin/bash

kitty +kitten icat \
    --clear \
    >/dev/null 2>&1

kitty +kitten icat \
    --place="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" \
    "$1"
