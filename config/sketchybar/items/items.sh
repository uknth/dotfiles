#!/usr/bin/env zsh


# current_space item
cs_name="spaceicon" 
cs_bag=

cs_config=(
    icon=$icon_page 
    icon.padding_left=3
    icon.padding_right=2
    icon.y_offset=0
    icon.font.size=16
    background.color="0xfff2cdcd"
    background.corner_radius=2
    label.drawing=on
    script="$config_dir/items/current_space.sh"
)


sketchybar --add item $cs_name left \
    --set $cs_name\
    "${cs_config[@]}" \
    --subscribe $cs_name space_change mouse.clicked \



sl_name="spacelabel"
sl_config=(
    icon.drawing=off
    background.color="0xff1e1e2e"
    background.corner_radius=2
    label.drawing=off
    script="$config_dir/items/current_space.sh"
)


    
