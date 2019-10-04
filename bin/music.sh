#!/usr/bin/env bash
exec ~/.bin/tmux_attach -t Music mpdc music "tmux set status off; ncmpcpp"
