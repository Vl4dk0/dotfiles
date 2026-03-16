#!/usr/bin/env bash

if ! command -v tmux >/dev/null 2>&1; then
    exit 1
fi

if ! command -v fzf >/dev/null 2>&1; then
    exit 1
fi

if ! tmux has-session 2>/dev/null; then
    exit 0
fi

selected=$(tmux list-sessions -F "#{session_name}" | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

if [[ -n $TMUX ]]; then
    tmux switch-client -t "$selected"
else
    tmux attach -t "$selected"
fi
