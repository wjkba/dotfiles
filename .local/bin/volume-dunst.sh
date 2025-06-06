#!/bin/bash

# A script to control volume using amixer and send notifications with Dunst.

# The name of the Master control for amixer. Use "amixer scontrols" to find yours.
SCONTROL='Master'

# Function to get the current volume percentage
get_volume() {
    amixer sget "$SCONTROL" | awk -F"[][]" '/%/ { print $2 }' | head -n1 | tr -d '%'
}

# Function to check if the volume is currently muted
is_muted() {
    amixer sget "$SCONTROL" | grep -q '\[off\]'
}

# Function to send a notification
send_notification() {
    local volume
    volume=$(get_volume)

    if is_muted; then
        dunstify -a "change-volume" -u low -i audio-volume-muted -t 1000 -h string:x-dunst-stack-tag:volume "Volume: Muted"
    else
        local icon
        if [ "$volume" -gt 66 ]; then
            icon="audio-volume-high"
        elif [ "$volume" -gt 33 ]; then
            icon="audio-volume-medium"
        else
            icon="audio-volume-low"
        fi
        
        dunstify -a "change-volume" -u low -i "$icon" -t 1000 -h string:x-dunst-stack-tag:volume \
        -h int:value:"$volume" "Volume: ${volume}%"
    fi
}

# Main logic: Handle script arguments
case $1 in
    up)
        # Unmute the volume if it's muted, otherwise increase by 5%
        amixer sset "$SCONTROL" 5%+ unmute > /dev/null
        send_notification
        ;;
    down)
        # Decrease the volume by 5%
        amixer sset "$SCONTROL" 5%- > /dev/null
        send_notification
        ;;
    mute)
        # Toggle mute
        amixer sset "$SCONTROL" toggle > /dev/null
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac
