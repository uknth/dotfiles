#!/bin/bash

window_label=$(yabai -m query --windows --window | jq -re '.["app"]')

config_dir="$CONFIG_DIR"

icon_result="$($config_dir/lib/icons.sh $window_label)"

sketchybar --set $NAME \
        label="$icon_result $window_label" \
        label.drawing=on
