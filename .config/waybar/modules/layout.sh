#!/bin/bash

# Define the layouts you use
LAYOUTS=("cz" "us")

# Get current layout from riverctl
# Note: This assumes you set your layout via riverctl in your init script
CURRENT=$(riverctl list-inputs | grep -A 10 "keyboard" | grep "layout" | awk '{print $2}' | head -n 1)

# If running as a Waybar module (no arguments), just output the uppercase shortcode
if [ -z "$1" ]; then
    echo "${CURRENT^^}"
    exit 0
fi

# If "next" is passed, toggle to the other layout
if [ "$1" == "next" ]; then
    if [ "$CURRENT" == "cz" ]; then
        riverctl input "type:keyboard" layout us
    else
        riverctl input "type:keyboard" layout cz
    fi
    # Signal Waybar to update immediately (assuming it's module 'custom/language')
    pkill -RTMIN+8 waybar
fi