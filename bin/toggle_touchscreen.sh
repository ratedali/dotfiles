#!/bin/sh

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

app_name="Touchscreen Toggler"
device_name="N-trig DuoSense"

state=$(xinput list-props "$device_name" | sed -nre 's/^.*Device Enabled.*:.*([[:digit:]])$/\1/p')

if [ $(($state)) -eq 1 ]; then
    notify-send -a "$app_name" --icon=dialog-information "Touchscreen Toggle" "Disabling $device_name" 
    xinput disable "$device_name"
else
    notify-send -a "$app_name" --icon=dialog-information "Touchscreen Toggle"  "Enabling $device_name"
    xinput enable "$device_name"
fi
