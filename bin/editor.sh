#!/usr/bin/env bash
exec ~/.bin/tmux_attach editor editor "${EDITOR:-nvim}"
