#!/bin/sh
choosen=$(ls /home/angeldx/dotfiles/scripts/dmenu/ | dmenu -i)
[ -n "$choosen" ] && exec /home/angeldx/dotfiles/scripts/dmenu/"$choosen"
