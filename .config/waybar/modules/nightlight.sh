#!/bin/bash

# Check if wlsunset is running
if pgrep -x "wlsunset" > /dev/null; then
    # Turn off wlsunset
    pkill wlsunset
    echo "🌙 Off"
else
    # Set wlsunset to 2500K
    wlsunset -r 2500
    echo "🌙 2500K"
fi
