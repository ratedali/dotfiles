#!/bin/sh

theme="${1:-materia}"
icons="${2:-suruplus_aspromauros}"


theme_path="/opt/oomox/plugins/theme_$theme/$theme-theme"
if [ -n "$theme" -a -d "$theme_path" ]; then
    $theme_path/change_color.sh -o wal --hidpi True $HOME/.cache/wal/colors-oomox > /dev/null
    /usr/bin/notify-send --icon=preferences-color  "Generated UI theme!"
fi
if [ $? -ne 0 ]; then
    /usr/bin/notify-send --icon=error "An error occured while tweaking the UI theme" "Try again from a terminal to see the error"
fi

icons_path="/opt/oomox/plugins/icons_$icons"
if [ -n "$icons" -a -d "$icons_path" ]; then
    $icons_path/change_color.sh -o wal $HOME/.cache/wal/colors-oomox > /dev/null
    /usr/bin/notify-send --icon=preferences-color  "Generated icons theme!"
fi
if [ $? -ne 0 ]; then
    /usr/bin/notify-send --icon=error "An error occured while generating the icons theme" "Try again from a terminal to see the error"
fi

# vim:ft=sh
