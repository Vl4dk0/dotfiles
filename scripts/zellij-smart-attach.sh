#!/usr/bin/env bash

# Check if zellij is installed
if ! command -v zellij >/dev/null; then
    echo "Error: Zellij is not installed."
    exit 1
fi

# Get list of sessions with details (stripping color codes for clean processing if needed,
# but keeping them for fzf display is usually better. Zellij output is colored by default).
ZJ_SESSIONS=$(zellij list-sessions 2>/dev/null)
NO_SESSIONS_MSG="No active sessions"

# Case with no sessions
if [[ -z "$ZJ_SESSIONS" ]]; then
    ZJ_SESSIONS="$NO_SESSIONS_MSG"
fi

NEW_SESSION_OPT="[CREATE NEW SESSION]"

# Combine existing sessions and the new option
MENU="$NEW_SESSION_OPT\n$ZJ_SESSIONS"

# Pass to fzf
# --ansi: interprets color codes from zellij output
# --header: Instructions
SELECTED_LINE=$(echo -e "$MENU" | fzf --ansi)

if [[ -z "$SELECTED_LINE" ]]; then
    exit 0
fi

if [[ "$SELECTED_LINE" == "$NEW_SESSION_OPT" ]]; then
    read -p "Enter new session name: " SESSION_NAME

    layout_file="$HOME/dotfiles/zellij/layouts/three-tab-default.kdl"
    
    # If empty, let Zellij generate a random name
    if [[ -z "$SESSION_NAME" ]]; then
        if [[ -f "$layout_file" ]]; then
            zellij -n "$layout_file"
        else
            zellij
        fi
    else
        if [[ -f "$layout_file" ]]; then
            zellij -n "$layout_file" -s "$SESSION_NAME"
        else
            zellij -s "$SESSION_NAME"
        fi
    fi
    exit 0
else
    # Extract session name (first word of the selected line)
    SESSION_NAME=$(echo "$SELECTED_LINE" | awk '{print $1}')
    zellij attach "$SESSION_NAME"
fi
