#!/bin/bash

# Set your wallpapers directory
WALLPAPER_DIR="$HOME/Pictures/wall"

# Pick a wallpaper using dmenu
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | dmenu -i)

# If a file was selected, apply it using feh
if [ -n "$SELECTED" ]; then
    feh --bg-scale "$SELECTED"
fi

