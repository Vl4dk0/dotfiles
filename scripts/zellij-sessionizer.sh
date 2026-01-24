#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dotfiles/ ~/Documents/ ~/School/ ~/nexana-all/ ~/Projects/ -mindepth 0 -maxdepth 1 -type d 2>/dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

# Sanitize session name
selected_name=$(basename "$selected" | tr . _)

# Check if we are currently inside a Zellij session
if [[ -n $ZELLIJ ]]; then
    echo "Already in a Zellij session. Use 'Ctrl + a' then 'o + w' to switch sessions."
    exit 0
fi

# Check if the session exists
if zellij list-sessions 2>/dev/null | grep -q "^${selected_name} "; then
    zellij attach "$selected_name"
else
    cd "$selected"
    layout_file="$HOME/dotfiles/zellij/layouts/three-tab-default.kdl"
    if [[ -f "$layout_file" ]]; then
        zellij -n "$layout_file" -s "$selected_name"
    else
        zellij -s "$selected_name"
    fi
fi
