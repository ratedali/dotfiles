if test -n "$TMUX"
    set -x FZF_TMUX 1
end

if functions -q fzf_key_bindings
    fzf_key_bindings
end
