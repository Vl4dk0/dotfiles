#!/usr/bin/env bash

# Select directory using the same logic as your tmux script
if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Combined finding logic from your previous script
    selected=$(find ~/dotfiles/ ~/Documents/ ~/School/ ~/nexana-all/ ~/CSES/ ~/ICPC/ ~/invoice_generator/ -mindepth 0 -maxdepth 1 -type d 2>/dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

# Sanitize session name (Zellij is strict about session names)
selected_name=$(basename "$selected" | tr . _)

# Check if we are currently inside a Zellij session
if [[ -n $ZELLIJ ]]; then
    echo "Already in a Zellij session. Use 'Ctrl + o' then 'w' to switch sessions."
    exit 0
fi

# Check if the session exists
# 'zellij list-sessions' output format: "session-name [Created X ago] (Attached)"
if zellij list-sessions 2>/dev/null | grep -q "^$selected_name "; then
    # Attach to existing session
    zellij attach "$selected_name"
else
    # Create new session in the selected directory
    cd "$selected"
    zellij -s "$selected_name"
fi
