#!/bin/sh

charging_icon="󰂄"
full_icon="󰁹"
high_icon="󰂁"
medium_icon="󰁿"
low_icon="󰁽"
critical_icon="󰂃"
unknown_icon="󰂎"

# Get battery info (works on most Linux systems)
capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1)

if [ -z "$capacity" ] || [ -z "$status" ]; then
    echo "$unknown_icon"
    exit
fi

# Choose icon based on charge and status
if [ "$status" = "Charging" ]; then
    icon="$charging_icon"
elif [ "$status" = "Full" ]; then
    icon="$charging_icon"
else
    if [ "$capacity" -ge 90 ]; then
        icon="$full_icon"
    elif [ "$capacity" -ge 70 ]; then
        icon="$high_icon"
    elif [ "$capacity" -ge 40 ]; then
        icon="$medium_icon"
    elif [ "$capacity" -ge 20 ]; then
        icon="$low_icon"
    else
        icon="$critical_icon"
    fi
fi

echo "$icon$capacity%"
