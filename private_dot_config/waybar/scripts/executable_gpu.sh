#!/bin/bash

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)

if [ -z "$usage" ]; then
    echo "󰢮 N/A"
    exit 0
fi

if [ "$usage" -ge 90 ]; then
    echo "󰀨 ${usage}%"
elif [ "$usage" -ge 75 ]; then
    echo "󰀨 ${usage}%"
else
    echo "󰍛 ${usage}%"
fi
