#!/bin/sh

wifi_icon="󰤨 "
eth_icon="󰈀 "
no_net_icon="󰤮 "

# Get list of active devices
active_device=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev status | awk -F: '
$3 == "connected" {
    if ($2 == "wifi") {
        print "wifi"
        exit
    } else if ($2 == "ethernet") {
        print "ethernet"
        exit
    }
}')

if [ "$active_device" = "wifi" ]; then
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    echo "$wifi_icon $ssid"
elif [ "$active_device" = "ethernet" ]; then
    echo "$eth_icon"
else
    echo "$no_net_icon"
fi

