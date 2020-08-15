#!/bin/bash

rofi -show drun -font "Hack 12" -run-shell-command '{terminal} -e " {cmd}; read -n 1 -s"' 
