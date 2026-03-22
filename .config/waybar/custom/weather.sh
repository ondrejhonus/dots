#!/bin/bash

# Fetch current status for the bar (emoji + temp)
text=$(curl -s "wttr.in/?format=1")

# Fetch the full ASCII forecast
# T: No colors (Waybar tooltips don't handle ANSI escape codes well)
# Q: Quiet (removes the "Follow @igor_chubin" footer)
# Note: Remove the '0' if you want the full 3-day forecast instead of just today
tooltip=$(curl -s "wttr.in/Bolatice?2T" | sed 's/\\/\\\\/g; s/"/\\"/g' | awk '{printf "%s\\n", $0}')

# Return as JSON for Waybar
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"