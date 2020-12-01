#!/bin/sh
pos=$(playerctl position)
if [[ "$(echo $pos / 1 | bc)" -gt 5 ]]; then
   playerctl position 0
else
    playerctl previous
fi
