#!/bin/bash

# check for binaries
if ! command -v yabai &> /dev/null; then
    echo "yabai could not be found" ; exit 1
fi
if ! command -v jq &> /dev/null; then
    echo "jq could not be found" ; exit 1
fi

# Get config on event
space=$(yabai -m query --windows --window "$YABAI_WINDOW_ID" | jq -re '.["space"]')
has_border=$(yabai -m query --windows --window "$YABAI_WINDOW_ID" | jq -re '.["has-border"]')
flag="false"

# No borders on spaces 1,7,8,9 as they are floating spaces
if [[ "$has_border" == "true"  &&  "$space" == "1" ]]; then flag="true"; fi
if [[ "$has_border" == "true"  &&  "$space" == "7" ]]; then flag="true"; fi
if [[ "$has_border" == "true"  &&  "$space" == "8" ]]; then flag="true"; fi
if [[ "$has_border" == "true"  &&  "$space" == "9" ]]; then flag="true"; fi

if [[ "$flag" == "true" ]]; then 
    yabai -m window "$YABAI_WINDOW_ID" --toggle border
fi