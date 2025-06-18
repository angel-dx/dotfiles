#!/bin/sh

# Set a random wallpaper on startup
feh --bg-scale "$(find ~/Pictures/wall -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)"

picom -b

dunst & #notification daemon

dwmblocks &

ghostty &

while true; do
  dwm || break
done
dwm &

miniserve ~/angel-dx/share/ --upload-files &
