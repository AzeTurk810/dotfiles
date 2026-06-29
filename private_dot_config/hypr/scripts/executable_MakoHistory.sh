#!/bin/bash

notification=$(
    makoctl history |
    jq -r '.data[] | "\(.id)\t\(.app-name.data): \(.summary.data)"' |
    fzf \
        --height=100% \
        --layout=reverse \
        --delimiter='\t' \
        --with-nth=2 \
        --preview='
            id=$(echo {} | cut -f1)
            makoctl history |
            jq --arg id "$id" -r \
            ".data[] | select((.id|tostring)==\$id) |
            \"App: \(.\"app-name\".data)

Summary:
\(.summary.data)

Body:
\(.body.data)\""
        ' \
        --preview-window=right:60%
)

[[ -z "$notification" ]] && exit

id=$(echo "$notification" | cut -f1)

choice=$(
    printf "Invoke\nDismiss\nCopy body" | fzf --prompt="Action > "
)

case "$choice" in
    Invoke)
        makoctl invoke "$id"
        ;;
    Dismiss)
        makoctl dismiss "$id"
        ;;
    "Copy body")
        makoctl history |
        jq --arg id "$id" -r \
        '.data[] | select((.id|tostring)==$id) | .body.data' |
        wl-copy
        ;;
esac
