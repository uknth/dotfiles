#!/bin/bash

# Shows label of space
#
# current_space item
cs_name="space_label" 
cs_bag=

cs_config=(
    background.color="0xff181825"
    background.corner_radius=2
    label.drawing=on
    label.color="0xffcdd6f4"
    label.padding_left=0
    label.padding_right=10
    script="$config_dir/scripts/space_label.sh"
)


sketchybar --add item $cs_name left \
    --set $cs_name\
    "${cs_config[@]}" \
    --subscribe $cs_name space_change mouse.clicked \


