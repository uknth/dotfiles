#!/bin/bash

wl_name="window_label"

wl_config=(
  icon=""
  icon.padding_left=5
  icon.font.size=14
  background.color="0xffa6e3a1"
  background.corner_radius=2
  label.color="0xff181825"
  label.padding_right=15
  script="$config_dir/scripts/window_label.sh"
)

sketchybar --add item $wl_name left \
    --set $wl_name \
    "${wl_config[@]}" \
    --subscribe $wl_name space_change front_app_switched mouse.clicked

