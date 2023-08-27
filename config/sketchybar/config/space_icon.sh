#!/bin/bash

# current_space item
cs_name="space_icon" 

cs_config=(
    icon.padding_left=3
    icon.padding_right=2
    icon.y_offset=0
    icon.font.size=16
    icon.color="0xff313244"
    label.color="0xff313244"
    background.color="0xfff2cdcd"
    background.corner_radius=2
    label.drawing=on
    label.padding_right=5
    script="$config_dir/scripts/space_icon.sh"
)


sketchybar --add item $cs_name left \
    --set $cs_name\
    "${cs_config[@]}" \
    --subscribe $cs_name space_change mouse.clicked \


