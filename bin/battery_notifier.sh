#!/bin/sh

## battery_notifier.sh
# checks the current state of the battery and the charger of the laptop using ACPI
# if the battery is over 80% and charging or under 40% and discharging, it sends
# a notification to the display specified by the DISPLAY environment variable

#         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                 Version 2, December 2004
#
# Copyright 2016 yourname
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.



battery_state=$(acpi -b | cut -d: -f2 | cut -d, -f2 | sed -e 's:\s\+::' | sed -e 's:%::')
ac_connected=$(acpi -a | cut -d: -f2 | sed -e 's:\s\+::')

function notify_device {
    # Sends a notification to the first connected device using KDEConnect
    # the first argument is used as the notification message
    id=$(kdeconnect-cli --id-only -la | head -1)
    if [ -n "$id" ]; then
        kdeconnect-cli -d "$id" --ping-msg "$1"
    fi
    return 0
}

if [ "$battery_state" -gt 80 -a "$ac_connected" == "on-line" ]; then
    message="Unplug the charger"
    notify-send -a "Battery Status" --icon=battery "Battery Level Over 80%" "$message"
    notify_device "$message"
elif [ "$battery_state" -lt 40 -a "$ac_connected" == "off-line" ]; then
    message="Plug in the charger"
    notify-send -a "Battery Status" --icon=battery "Battery Level Below 40%" "$message"
    notify_device "$message"
fi
