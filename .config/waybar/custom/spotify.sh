#!/bin/bash

# Fetch data
artist=$(spotifycli --artist 2>/dev/null)
song=$(spotifycli --song 2>/dev/null)

# Exit if nothing is playing
if [ -z "$artist" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"Stopped\"}"
    exit 0
fi

# Get lyrics and escape them for JSON
lyrics=$(spotifycli --lyrics 2>/dev/null | sed 's/\\/\\\\/g; s/"/\\"/g' | awk '{printf "%s\\n", $0}')

# Fallback if no lyrics found
if [[ -z "$lyrics" || "$lyrics" == "\\n" ]]; then
    lyrics="<i>Lyrics not available</i>"
fi

# Construct the Pango-styled tooltip
# <b> for the header, <span size='smaller'> for the lyrics
full_tooltip="<span foreground='#aaffaa'>$artist | $song\n\n<span size='7500'>$lyrics</span></span>"

# Output for Waybar
echo "{\"text\": \"$artist\", \"tooltip\": \"$full_tooltip\"}"