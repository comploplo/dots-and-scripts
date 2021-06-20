#!/bin/bash

picom &
xset b off
xset s off
setxkbmap -option ctrl:nocaps
theme set best-dark
xrdb -load ~/.Xresources
/usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
