#!/bin/bash

# Dynamic Volume & Brightness Menu for Rofi
# Save as: ~/dotfiles/scripts/dx-volalph.sh
# Make executable: chmod +x ~/dotfiles/scripts/dx-volalph.sh

# Dependencies: pamixer, brightnessctl, dunst (for notifications)

# Icons
volume_icon="󰕾"
brightness_icon="󰃠"
mute_icon="󰖁"
separator="────────────────────────"

# Functions
get_volume() {
    pamixer --get-volume 2>/dev/null || echo "0"
}

get_mute_status() {
    pamixer --get-mute 2>/dev/null && echo "true" || echo "false"
}

get_brightness() {
    brightnessctl get 2>/dev/null | head -1 || echo "0"
}

get_max_brightness() {
    brightnessctl max 2>/dev/null | head -1 || echo "100"
}

get_brightness_percent() {
    local current=$(get_brightness)
    local max=$(get_max_brightness)
    if [[ $max -gt 0 ]]; then
        echo $(( current * 100 / max ))
    else
        echo "0"
    fi
}

create_bar() {
    local value=$1
    local max_value=${2:-100}
    local bar_length=20
    local filled=$(( value * bar_length / max_value ))
    local empty=$(( bar_length - filled ))

    local bar=""
    for ((i=0; i<filled; i++)); do
        bar+="█"
    done
    for ((i=0; i<empty; i++)); do
        bar+="░"
    done
    echo "$bar"
}

send_notification() {
    local title=$1
    local message=$2
    local icon=$3
    local value=$4

    if command -v dunstify &> /dev/null; then
        dunstify -a "System" -u low -i "$icon" -h int:value:$value -h string:x-canonical-private-synchronous:system "$title" "$message"
    elif command -v notify-send &> /dev/null; then
        notify-send -u low "$title" "$message"
    fi
}

# Get current values
current_volume=$(get_volume)
is_muted=$(get_mute_status)
current_brightness=$(get_brightness_percent)

# Create visual bars
volume_bar=$(create_bar $current_volume)
brightness_bar=$(create_bar $current_brightness)

# Volume display
if [[ $is_muted == "true" ]]; then
    volume_display="$mute_icon Muted        [${volume_bar}] 0%"
else
    volume_display="$volume_icon Volume       [${volume_bar}] ${current_volume}%"
fi

# Brightness display
brightness_display="$brightness_icon Brightness   [${brightness_bar}] ${current_brightness}%"

# Menu options
options="${volume_display}\n${brightness_display}"

# Show menu
chosen="$(echo -e "$options" | rofi -dmenu -i -p "Audio & Display" -theme /home/angeldx/.config/rofi/themes/dx-volalph.rasi -selected-row 0)"

# Handle selection
case $chosen in
    *"Volume +10%"*)
        new_volume=$(( current_volume + 10 ))
        [[ $new_volume -gt 100 ]] && new_volume=100
        pamixer --set-volume $new_volume
        send_notification "Volume" "${new_volume}%" "audio-volume-high" $new_volume
        ;;
    *"Volume -10%"*)
        new_volume=$(( current_volume - 10 ))
        [[ $new_volume -lt 0 ]] && new_volume=0
        pamixer --set-volume $new_volume
        send_notification "Volume" "${new_volume}%" "audio-volume-low" $new_volume
        ;;
    *"Toggle Mute"*)
        pamixer --toggle-mute
        if pamixer --get-mute; then
            send_notification "Volume" "Muted" "audio-volume-muted" 0
        else
            current_vol=$(get_volume)
            send_notification "Volume" "Unmuted - ${current_vol}%" "audio-volume-high" $current_vol
        fi
        ;;
    *"Brightness +10%"*)
        brightnessctl set +10%
        new_brightness=$(get_brightness_percent)
        send_notification "Brightness" "${new_brightness}%" "brightness-high" $new_brightness
        ;;
    *"Brightness -10%"*)
        brightnessctl set 10%-
        new_brightness=$(get_brightness_percent)
        send_notification "Brightness" "${new_brightness}%" "brightness-low" $new_brightness
        ;;
    *"Quick Settings"*)
        # Sub-menu for quick presets
        quick_options="🔊 Volume 100%\n🔉 Volume 50%\n🔇 Volume 25%\n☀️ Brightness 100%\n🌗 Brightness 50%\n🌙 Brightness 25%\n🌚 Night Mode (10%)\n❌ Back"
        quick_chosen="$(echo -e "$quick_options" | rofi -dmenu -i -p "Quick Settings" -theme /home/angeldx/.config/rofi/themes/dx-volalph.rasi)"

        case $quick_chosen in
            *"Volume 100%"*)
                pamixer --set-volume 100
                send_notification "Volume" "100%" "audio-volume-high" 100
                ;;
            *"Volume 50%"*)
                pamixer --set-volume 50
                send_notification "Volume" "50%" "audio-volume-medium" 50
                ;;
            *"Volume 25%"*)
                pamixer --set-volume 25
                send_notification "Volume" "25%" "audio-volume-low" 25
                ;;
            *"Brightness 100%"*)
                brightnessctl set 100%
                send_notification "Brightness" "100%" "brightness-high" 100
                ;;
            *"Brightness 50%"*)
                brightnessctl set 50%
                send_notification "Brightness" "50%" "brightness-medium" 50
                ;;
            *"Brightness 25%"*)
                brightnessctl set 25%
                send_notification "Brightness" "25%" "brightness-low" 25
                ;;
            *"Night Mode"*)
                brightnessctl set 10%
                send_notification "Night Mode" "10% brightness" "brightness-low" 10
                ;;
        esac
        ;;
    *"Cancel"*)
        exit 0
        ;;
    *)
        # If clicked on the status bars, open fine adjustment
        if [[ $chosen == *"Volume"* ]]; then
            # Fine volume adjustment
            fine_options="🔊 +5%\n🔊 +1%\n🔉 -1%\n🔉 -5%\n🔇 Toggle Mute\n❌ Back"
            fine_chosen="$(echo -e "$fine_options" | rofi -dmenu -i -p "Fine Volume" -theme /home/angeldx/.config/rofi/themes/dx-volalph.rasi)"

            case $fine_chosen in
                *"+5%"*)
                    new_vol=$(( current_volume + 5 ))
                    [[ $new_vol -gt 100 ]] && new_vol=100
                    pamixer --set-volume $new_vol
                    send_notification "Volume" "${new_vol}%" "audio-volume-high" $new_vol
                    ;;
                *"+1%"*)
                    new_vol=$(( current_volume + 1 ))
                    [[ $new_vol -gt 100 ]] && new_vol=100
                    pamixer --set-volume $new_vol
                    send_notification "Volume" "${new_vol}%" "audio-volume-high" $new_vol
                    ;;
                *"-1%"*)
                    new_vol=$(( current_volume - 1 ))
                    [[ $new_vol -lt 0 ]] && new_vol=0
                    pamixer --set-volume $new_vol
                    send_notification "Volume" "${new_vol}%" "audio-volume-low" $new_vol
                    ;;
                *"-5%"*)
                    new_vol=$(( current_volume - 5 ))
                    [[ $new_vol -lt 0 ]] && new_vol=0
                    pamixer --set-volume $new_vol
                    send_notification "Volume" "${new_vol}%" "audio-volume-low" $new_vol
                    ;;
                *"Toggle Mute"*)
                    pamixer --toggle-mute
                    if pamixer --get-mute; then
                        send_notification "Volume" "Muted" "audio-volume-muted" 0
                    else
                        current_vol=$(get_volume)
                        send_notification "Volume" "Unmuted - ${current_vol}%" "audio-volume-high" $current_vol
                    fi
                    ;;
            esac
        elif [[ $chosen == *"Brightness"* ]]; then
            # Fine brightness adjustment
            fine_options="☀️ +5%\n☀️ +1%\n🌙 -1%\n🌙 -5%\n🌚 Night Mode\n❌ Back"
            fine_chosen="$(echo -e "$fine_options" | rofi -dmenu -i -p "Fine Brightness" -theme /home/angeldx/.config/rofi/themes/dx-volalph.rasi)"

            case $fine_chosen in
                *"+5%"*)
                    brightnessctl set +5%
                    new_brightness=$(get_brightness_percent)
                    send_notification "Brightness" "${new_brightness}%" "brightness-high" $new_brightness
                    ;;
                *"+1%"*)
                    brightnessctl set +1%
                    new_brightness=$(get_brightness_percent)
                    send_notification "Brightness" "${new_brightness}%" "brightness-high" $new_brightness
                    ;;
                *"-1%"*)
                    brightnessctl set 1%-
                    new_brightness=$(get_brightness_percent)
                    send_notification "Brightness" "${new_brightness}%" "brightness-low" $new_brightness
                    ;;
                *"-5%"*)
                    brightnessctl set 5%-
                    new_brightness=$(get_brightness_percent)
                    send_notification "Brightness" "${new_brightness}%" "brightness-low" $new_brightness
                    ;;
                *"Night Mode"*)
                    brightnessctl set 10%
                    send_notification "Night Mode" "10% brightness" "brightness-low" 10
                    ;;
            esac
        fi
        ;;
esac
