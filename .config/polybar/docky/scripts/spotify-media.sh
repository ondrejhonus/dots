#!/bin/bash

spotify_status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$spotify_status" == "Playing" ]]; then
    song=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}')
    echo "%{A1:playerctl --player=spotify previous:}%{A} %{A1:playerctl --player=spotify play-pause:}$( [[ $spotify_status == Playing ]] && echo "" || echo "" )%{A} %{A1:playerctl --player=spotify next:}%{A}  $song"
else
    # If Spotify is not running, check for any other player
    status=$(playerctl status 2>/dev/null)
    if [[ "$status" == "Playing" ]]; then
        song=$(playerctl metadata --format '{{ artist }} - {{ title }}')
        echo "%{A1:playerctl previous:}%{A} %{A1:playerctl play-pause:}$( [[ $status == Playing ]] && echo "" || echo "" )%{A} %{A1:playerctl next:}%{A}  $song"
    else
        if [[ "$spotify_status" == "Paused" ]]; then
        song=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}')
        echo "%{A1:playerctl --player=spotify previous:}%{A} %{A1:playerctl --player=spotify play-pause:}$( [[ $spotify_status == Playing ]] && echo "" || echo "" )%{A} %{A1:playerctl --player=spotify next:}%{A}  $song"
        else
            echo " Offline"
        fi
    fi
fi
