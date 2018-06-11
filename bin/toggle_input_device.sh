#!/bin/bash

#         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                 Version 2, December 2004
#
# Copyright 2016 Ali Salah
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

# Toggles a given input device using xinput and issues a notification on $DISPLAY
# Usage:
#     toggle_input_device.sh [OPTIONS] DEVICE_NAME [APP_NAME]
# DEVICE_NAME   is the device name found on the output of 'xinput list'
# APP_NAME      is optional. If given it's used for notifications as a message,
#               otherwise the device name will be used for generating a message
# OPTIONS:
#     -h        show this help message
#     -q        disables notifications

print_help() {
   cat >&2 << EOM
Usage:
    toggle_input_device.sh [OPTIONS] DEVICE_NAME [APP_NAME]
DEVICE_NAME   is the device name found on the output of 'xinput list'
APP_NAME      is optional. If given it's used for notifications as a message,
              otherwise the device name will be used for generating a message
OPTIONS:
    -h        show this help message
    -q        disables notifications
EOM
}


if [[ $# -eq 0 || ("$1" == "-q" && $# -eq 1) ]]; then
    echo "Device name not given" >&2
    print_help
    exit 1
fi

if [[ "$1" == "-h" ]]; then
    print_help
    exit 0
fi

if [[ "$1" == "-q" ]]; then
    device_name="$2"
    app_name_provided=$([[ -n "$3" ]])
    app_name="$3"
else
    notifications=1
    device_name="$1"
    app_name_provided=$([[ -n "$2" ]])
    app_name="$2"
fi

if [[ ! $app_name_provided ]]; then
    app_name="$device_name Toggler"
fi


state=$(xinput list-props "$device_name" | sed -nre 's/^.*Device Enabled.*:.*([[:digit:]])$/\1/p')
if [[ -z "$state" ]]; then
    echo "Either the device does not exist, or its state cannot be changed" >&2
fi

if [[ $(($state)) -eq 1 ]]; then
    [[ $notifications ]] && notify-send -a "$app_name" --icon=dialog-information "$app_name" "Disabling $device_name" 
    xinput disable "$device_name"
else
    [[ $notifications ]] && notify-send -a "$app_name" --icon=dialog-information "$app_name"  "Enabling $device_name"
    xinput enable "$device_name"
fi
