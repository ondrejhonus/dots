#!/bin/sh
# Requires 'jqp' or simple file reading, this example uses swaymsg-like logic 
# which can be adapted for river using riverctl
riverctl list-input-devices | grep -m1 "xkb_layout" | awk '{print $2}'
