#!/bin/bash

layout=$(hyprctl devices | grep -i "active keymap")

if echo "$layout" | grep -q "Czech (QWERTY)"; then
    echo "🇨🇿"
else
    echo "🇺🇸"
fi
