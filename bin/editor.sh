#!/usr/bin/env bash
exec ~/.bin/tmux_attach -t Editor editor editor "${EDITOR:-nvim}"
