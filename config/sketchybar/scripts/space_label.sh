#!/bin/bash


space_id=$(echo "$INFO" | jq -r '."display-1"')
space_label=$(yabai -m query --spaces --space |  jq -re '.["label"]')

icon_right_arrow=""
label="$(echo $space_id $icon_right_arrow $space_label)"

if [ "$space_label" == "" ]; then
    label="$space_id"
fi

sketchybar --set $NAME \
    label="$label"
