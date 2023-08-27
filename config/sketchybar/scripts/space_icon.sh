#!/bin/bash

# ❯ yabai -m query --spaces --space
# {
#         "id":4,
#         "uuid":"5DF94245-515A-423C-BF6D-7A673F2C04A8",
#         "index":3,
#         "label":"Code",
#         "type":"bsp",
#         "display":1,
#         "windows":[23],
#         "first-window":23,
#         "last-window":23,
#         "has-focus":true,
#         "is-visible":true,
#         "is-native-fullscreen":false
# }

icon_home=""
icon_page="󰮰"
icon_browser=""
icon_code=""
icon_note="󰎞"
icon_chat="󰭹"
icon_music="󰎄"


space_id=$(echo "$INFO" | jq -r '."display-1"')
    
case $space_id in
    1)
        icon=$icon_home
        ;;
    2)
        icon=$icon_browser
        ;;
    3)
        icon=$icon_code
        ;;
    4)
        icon=$icon_note
        ;;
    5)
        icon=$icon_chat
        ;;
    6)
        icon=$icon_music
        ;;
    *)
        icon=$icon_page
        ;;
esac


sketchybar --set $NAME \
        icon=$icon \
        label="$space_id"

