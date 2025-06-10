#!/bin/bash

options="10\n20\n30\n50\n75\n100"
choice=$(echo -e "$options" | dmenu)

if [[ -n "$choice" ]]; then
	brightnessctl set "${choice}%"
fi

