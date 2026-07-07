#!/bin/bash

while true; do
    choice=$(
        makoctl history -j |
        jq -r '.[] | "\(.id)\t[\(.urgency)] \(.app_name): \(.summary)"' |
        fzf \
            --reverse \
            --header=$'Enter: restore\nCtrl-D: dismiss\nCtrl-C: exit' \
            --bind='ctrl-d:accept'
    ) || exit

    id=$(awk '{print $1}' <<<"$choice")

    [[ -z "$id" ]] && exit

    key=$(cat)

    makoctl restore
done
