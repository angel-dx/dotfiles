#!/bin/bash

# Rofi Power Menu Script
# Save as: ~/dotfiles/scripts/dx-power.sh
# Make executable: chmod +x ~/dotfiles/scripts/dx-power.sh

# Icons (using Nerd Font icons)
shutdown_icon="⏻"
reboot_icon="󰜉"
logout_icon="󰍃"
hibernate_icon="󰤄"
cancel_icon="󰜺"

# Options
options="$logout_icon Logout\n$hibernate_icon Hibernate\n$reboot_icon Reboot\n$shutdown_icon Shutdown\n$cancel_icon Cancel"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -matching fuzzy -theme ~/.config/rofi/themes/dx-power.rasi)"

# Execute based on choice
case $chosen in
    "$shutdown_icon Shutdown")
        # Confirmation dialog
        confirm=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Shutdown system?" -theme ~/.config/rofi/themes/dx-power.rasi)
        if [[ $confirm == "Yes" ]]; then
            systemctl poweroff
        fi
        ;;
    "$reboot_icon Reboot")
        # Confirmation dialog
        confirm=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Reboot system?" -theme ~/.config/rofi/themes/dx-power.rasi)
        if [[ $confirm == "Yes" ]]; then
            systemctl reboot
        fi
        ;;
    "$logout_icon Logout")
        # Confirmation dialog
        confirm=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Logout from session?" -theme ~/.config/rofi/themes/dx-power.rasi)
        if [[ $confirm == "Yes" ]]; then
            # For qtile
            qtile cmd-obj -o cmd -f shutdown
            # Alternative methods (uncomment the one that works for your setup):
            # loginctl terminate-session ${XDG_SESSION_ID-}
            # pkill -KILL -u "$USER"
        fi
        ;;
    "$hibernate_icon Hibernate")
        # Optional confirmation
        confirm=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Hibernate system?" -theme ~/.config/rofi/themes/dx-power.rasi)
        if [[ $confirm == "Yes" ]]; then
            # Lock first (optional)
            if command -v i3lock &> /dev/null; then
                i3lock -c 000000 -f &
            fi
            systemctl hibernate
        fi
        ;;
    "$cancel_icon Cancel")
        exit 0
        ;;
    *)
        # If nothing is selected or ESC is pressed
        exit 0
        ;;
esac
