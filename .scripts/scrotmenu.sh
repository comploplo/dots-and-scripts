#!/bin/bash

filename=~/pics/scrots/"$(date -Iminutes).png"

# options to be displayed
option0="area"
option1="screen"
option2="window"

# options to be displyed
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -width 12 -lines 3 -dmenu -p "scrot")"
case $selected in
    $option0)
        sleep 1 && ~/.scripts/scrt-select;;
    $option1)
        sleep 1 && ~/.scripts/scrt;;
    $option2)
        sleep 1 && scrot -u $filename
        xclip -selection clipboard -t image/png -i $filename;;
esac

