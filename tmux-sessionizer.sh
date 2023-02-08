#!/usr/bin/env bash

path=${1:-$(find ~ /etc/nixos{,/packages{,/scripts}} -mindepth 1 -maxdepth 1 \
    -type d | fzf)}
name=$(basename "$path" | tr . _)
# pid=$(pgrep tmux)
cmd=${2:-bash -l}

! tmux has-session -t="$name" 2>/dev/null && \
    tmux new-session -ds "$name" -c "$path" "$cmd"

# Tmux running, session name exists, 
tmux switch-client -t "$name" 2>/dev/null || tmux attach -t "$name"
