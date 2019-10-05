alias ip="ip --color=auto"
alias sway_tree "swaymsg -t get_tree | jq '.. | .nodes? | .[]? | select(.type == \"con\") | select(.name) | { name, app_id }'"
