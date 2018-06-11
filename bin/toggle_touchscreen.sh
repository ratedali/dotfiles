#!/bin/sh
device_name="N-trig DuoSense"
app_name="Touchscreen Toggler"
if [[ $# -gt 0 ]]; then
    ~/.bin/toggle_input_device.sh $@ "$device_name" "$app_name"
else
    ~/.bin/toggle_input_device.sh "$device_name" "$app_name"
fi
