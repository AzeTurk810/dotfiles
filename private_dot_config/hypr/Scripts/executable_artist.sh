#!/bin/bash
artist=$(playerctl metadata --format '{{artist}}' 2>/dev/null | cut -c 1-35)

echo "${artist}"
