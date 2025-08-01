#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dotfiles/ ~/Documents/ ~/Documents/nabu/Web_scraping_data/legal_ai/scrapping/microservices/ -mindepth 0 -maxdepth 1 -type d 2>/dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]] && tmux has-session -t=$selected_name 2>/dev/null; then
    tmux a -t $selected_name
    exit 0
fi

tmux switch-client -t $selected_name
