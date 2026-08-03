#!/usr/bin/env bash

trap "exit" PIPE
bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

cava -p ~/.config/cava/config-waybar | while IFS=';' read -ra vals; do
    out=""
    for v in "${vals[@]}"; do
        ((v<0)) && v=0
        ((v>7)) && v=7
        out+="${bars[$v]}"
    done
    printf '{"text":"%s"}\n' "$out"
done
