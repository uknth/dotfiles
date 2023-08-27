#!/bin/bash
#

# default bar definition
bar=(
  height=$bar_height
  blur_radius=0
  color=$bar_color
  border_width=2
  border_color=$bar_border_color
  shadow=off
  position=top
  sticky=on
  padding_right=$bar_padding
  padding_left=$bar_padding
  y_offset=$bar_y_offset
  margin=$bar_margin
  corner_radius=$bar_corner_radius
)


# default ui properties
defaults=(
  updates=when_shown
  icon.font="$icon_font"
  icon.color=$icon_color
  icon.padding_left=$icon_padding
  icon.padding_right=$icon_padding
  label.font="$font_face:Semibold:13.0"
  label.color=$label_color
  label.padding_left=$padding
  label.padding_right=$padding
  padding_right=$padding
  padding_left=$padding
  background.height=22
  background.corner_radius=9
  background.border_width=2
  popup.background.border_width=2
  popup.background.corner_radius=9
  popup.background.border_color=$popup_border_color
  popup.background.color=$popup_background_color
  popup.blur_radius=20
  popup.background.shadow.drawing=on
)

# Paths

sketchybar --bar "${bar[@]}"
sketchybar --default "${defaults[@]}"

