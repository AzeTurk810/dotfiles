#!/bin/bash

# Fayl prosesi statusu üçün
STATE_FILE="$HOME/.config/hypr/UserScripts/nightlight_state"

# Əgər fayl yoxdursa, default OFF
if [ ! -f "$STATE_FILE" ]; then
    echo off > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")
echo $STATE

if [ "$STATE" = "off" ]; then
    gammastep -O 3500 
    echo on > "$STATE_FILE"
    notify-send "🌙 Night Light" "ON"
else
    killall gammastep
    echo off > "$STATE_FILE"
    notify-send "🌙 Night Light" "OFF"
fi

