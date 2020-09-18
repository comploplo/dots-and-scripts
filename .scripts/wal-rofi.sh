#!/bin/bash
# Rofi script to list and pick wal theme
# Treat unset variables and parameters as errors￼
# options to be displayed
option0="wall"
option1="color"
option2="appreciate"
option3="delete"
rnd="random\n"
wals=$(ls /home/gabe/pics/wals | sed 's/\s\+/\n/g')

# options to be displyed
options="$option0\n$option1\n$option2\n$option3"

# Theme selection
if ! operation=$(echo -e $options | rofi -lines 4 -dmenu) ; then
    exit 1
fi
case $operation in
    $option0)
        if ! wall=$(echo $rnd$wals | rofi -dmenu); then
            exit 1
        fi
        /home/gabe/.scripts/theme wall $wall
        ;;
    $option1)
        sleep 1 && scrot -s $filename;;
    $option2)
        sleep 1 && scrot -u $filename;;
esac
