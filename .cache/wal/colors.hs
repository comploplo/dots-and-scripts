--Place this file in your .xmonad/lib directory and import module Colors into .xmonad/xmonad.hs config
--The easy way is to create a soft link from this file to the file in .xmonad/lib using ln -s
--Then recompile and restart xmonad.

module Colors
    ( wallpaper
    , background, foreground, cursor
    , color0, color1, color2, color3, color4, color5, color6, color7
    , color8, color9, color10, color11, color12, color13, color14, color15
    ) where

-- Shell variables
-- Generated by 'wal'
wallpaper="/home/gabe/Pictures/wals/gems/phil.jpg"

-- Special
background="#211e18"
foreground="#c7c6c5"
cursor="#c7c6c5"

-- Colors
color0="#211e18"
color1="#a6977b"
color2="#61ba96"
color3="#a1c2bb"
color4="#7fa7a2"
color5="#5875ab"
color6="#ab393d"
color7="#c7c6c5"
color8="#585651"
color9="#a6977b"
color10="#61ba96"
color11="#a1c2bb"
color12="#7fa7a2"
color13="#5875ab"
color14="#ab393d"
color15="#c7c6c5"
