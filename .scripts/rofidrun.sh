#!/bin/bash

rofi -show drun -font "Hack 10" -run-shell-command '{terminal} -e " {cmd}; read -n 1 -s"' 
