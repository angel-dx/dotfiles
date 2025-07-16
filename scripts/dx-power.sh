#!/usr/bin/env bash

# Rofi Power Menu Script - Robust, Modular
# Place this in ~/.config/rofi/powermenu.sh and make it executable

# Theme (optional, can be customized)
rofi_cmd="rofi -theme-str 'window { width: 20%; }' -dmenu -i -p 'Power Menu 🧠'"

# Power menu options
options=(
  "  Lock"
  "  Suspend"
  "⏾  Hibernate"
  "  Reboot"
  "⏻  Poweroff"
  "  Logout"
  "󰜺  Cancel"
)

# Convert array to newline-separated string for Rofi
choice=$(printf "%s\n" "${options[@]}" | $rofi_cmd)

# Confirmation prompt
confirm() {
  rofi -dmenu -i -p "Are you sure? (y/n)" <<< ""
}

# Commands
case "$choice" in
  *Lock*)
    if command -v i3lock >/dev/null; then
      i3lock
    elif command -v betterlockscreen >/dev/null; then
      betterlockscreen -l
    else
      notify-send "Lock command not found"
    fi
    ;;
  *Suspend*)
    confirm | grep -qi "^y" && systemctl suspend
    ;;
  *Hibernate*)
    confirm | grep -qi "^y" && systemctl hibernate
    ;;
  *Reboot*)
    confirm | grep -qi "^y" && systemctl reboot
    ;;
  *Poweroff*)
    confirm | grep -qi "^y" && systemctl poweroff
    ;;
  *Logout*)
    confirm | grep -qi "^y" && qtile cmd-obj -o cmd -f shutdown
    ;;
  *Cancel*|*)
    exit 0
    ;;
esac
