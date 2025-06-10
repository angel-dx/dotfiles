#!/bin/sh
choosen=$(ls /home/angeldx/dotfiles/scripts/dmenu/ | dmenu $DDF )
[ -n "$choosen" ] && exec /home/angeldx/dotfiles/scripts/dmenu/"$choosen"
