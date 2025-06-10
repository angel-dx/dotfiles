#!/bin/sh

choice=$(printf "Shutdown\nReboot\nLogout\nSuspend\nExit DWM" | dmenu)

case "$choice" in
  Shutdown) poweroff ;;
  Reboot) reboot ;;
  Logout) pkill -KILL -u "$USER" ;; # logs out user from session
  Suspend) systemctl suspend ;;
  "Exit DWM") pkill dwm ;;           # exits dwm like MOD+Shift+Q
  *) exit 1 ;;
esac

