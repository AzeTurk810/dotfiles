#!/bin/bash
title=$(playerctl metadata --format '{{title}}' 2>/dev/null | cut -c 1-30)

# Print "No Media" if $title is empty
echo "${title:-No Media}"
