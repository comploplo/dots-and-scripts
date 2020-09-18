#!/bin/bash

filename=~/pics/scrots/"$(date -Iminutes).png"

# options to be displayed
option0="screen"
option1="area"
option2="window"

# options to be displyed
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -lines 3 -dmenu -p "scrot")"
case $selected in
    $option0)
        sleep 1 && scrot $filename;;
    $option1)
        sleep 1 && scrot -s $filename;;
    $option2)
        sleep 1 && scrot -u $filename;;
esac

xclip -selection clipboard -t image/png -i $filename 
