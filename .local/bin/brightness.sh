#!/bin/bash

# Script to control and notify brightness changes

# Get the current brightness
get_brightness() {
  brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'
}

# Send the notification
send_notification() {
  local brightness=$(get_brightness)
  dunstify -a "change-brightness" -u low -i "display-brightness" \
  -h string:x-dunst-stack-tag:brightness -h int:value:"$brightness" "Brightness: ${brightness}%"
}

# Handle the script arguments
case $1 in
  up)
    brightnessctl set 5%+
    send_notification
    ;;
  down)
    brightnessctl set 5%-
    send_notification
    ;;
  *)
    echo "Usage: $0 {up|down}"
    exit 1
    ;;
esac
