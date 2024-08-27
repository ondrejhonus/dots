#!/bin/sh

vol="$(pamixer --get-volume-human)"

# Remove the '%' sign if present
vol_num="${vol%\%}"

if [ "$vol_num" -gt "70" ]; then
    icon="^c#FFFFFF^ "
elif [ "$vol_num" -lt "20" ]; then
    icon="^c#FFFFFF^ "
elif [ "$vol" = "muted" ]; then
    icon="^c#d64238^"
	vol=""
else
    icon="^c#FFFFFF^ "
fi

echo "| $icon$vol"
