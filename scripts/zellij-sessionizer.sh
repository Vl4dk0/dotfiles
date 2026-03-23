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

if [[ -n $ZELLIJ ]]; then
    zellij attach --create-background "$selected_name" options --default-cwd "$selected"
    zellij action switch-session "$selected_name"
else
    cd "$selected" && zellij attach --create "$selected_name"
fi
