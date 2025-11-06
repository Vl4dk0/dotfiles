#!/bin/bash

PATH="~/nexana/nexana-site"

if [[ -n "$TMUX" ]]; then
    echo "Detaching from the current tmux session..."
    tmux detach-client
fi

if tmux has-session -t nexana 2>/dev/null; then
    echo "Session 'nexana' already exists. Attaching..."
    tmux attach -t nexana
else
    tmux new -d -s nexana

    tmux split-window -h -t nexana:1
    tmux split-window -v -t nexana:1.1
    tmux split-window -v -t nexana:1.3

    tmux send-keys -t nexana:1.1 "cd $PATH" C-m
    tmux send-keys -t nexana:1.1 "cls" C-m
    tmux send-keys -t nexana:1.2 "cd $PATH" C-m
    tmux send-keys -t nexana:1.2 "cls" C-m
    tmux send-keys -t nexana:1.3 "cd $PATH" C-m
    tmux send-keys -t nexana:1.3 "cls" C-m
    tmux send-keys -t nexana:1.4 "cd $PATH" C-m
    tmux send-keys -t nexana:1.4 "cls" C-m

    tmux send-keys -t nexana:1.1 "yarn dev" C-m
    tmux send-keys -t nexana:1.3 "pa reverb:start" C-m
    tmux send-keys -t nexana:1.4 "pa horizon" C-m

    tmux new-window
    tmux send-keys -t nexana:2 "cd $PATH" C-m
    tmux send-keys -t nexana:2 "cls" C-m

    tmux attach -t nexana
fi
