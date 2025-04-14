#!/bin/bash

###############################################################################
# PULOGIKA.SH - Development Environment Setup for Logic Course
#
# Purpose: Creates a specialized tmux workspace for the Logic course that:
#   - Sets up a development environment for course work
#   - Manages Git branches for different assignments
#   - Provides a consistent workspace for course development
###############################################################################

# Configuration variables
log_base_dir="/home/vladko_jancar/school/2year2semester/logic" # Main repository location
prakt_dir="prakticke"                                          # Directory with assignments

###############################################################################
# SECTION 1: ENVIRONMENT VALIDATION
# These checks prevent common issues and ensure proper script execution
###############################################################################

# Prevent nested tmux sessions which can cause keybinding conflicts
if [ -n "$TMUX" ]; then
    echo "Already inside a tmux session. Please detach first (Ctrl+a, d)."
    exit 1
fi

# Check if a session already exists - don't allow duplicate sessions
if tmux has-session -t logic 2>/dev/null; then
    echo "Error: Session 'logic' already exists. Kill it first with: tmux kill-session -t logic"
    exit 1
fi

# Ensure the base directory exists before proceeding
if [ ! -d "$log_base_dir" ]; then
    echo "Base directory does not exist: $log_base_dir"
    exit 1
fi

###############################################################################
# SECTION 2: ASSIGNMENT SELECTION
# Uses fzf to provide a fuzzy-search interface for selecting assignment branches
###############################################################################

# Change to the repository directory first to ensure Git commands work
cd "$log_base_dir" || exit 1

# Fetch latest branches from remote to ensure we have the most up-to-date list
git fetch --all >/dev/null 2>&1

# Get all branches matching the 'du' followed by digits pattern and provide them to fzf
selected_branch=$(git branch --all | grep 'pu[0-9]\{2\}' |
    sed 's/^\s*//' | sed 's/^remotes\/origin\///' |
    sort | uniq |
    fzf-tmux -p --reverse --header="Select an assignment branch" --prompt="Branch > ")

# Exit if no branch was selected (user pressed Esc or Ctrl-C)
if [ -z "$selected_branch" ]; then
    echo "No branch selected. Exiting."
    exit 0
fi

# Clean up the branch name (remove any leading/trailing spaces or markers)
selected_branch=$(echo "$selected_branch" | sed 's/^\s*\*\?\s*//' | sed 's/\s*$//')

###############################################################################
# SECTION 3: TMUX WORKSPACE CREATION
# Creates a single-pane tmux session with the needed branch setup
###############################################################################

# Create a new detached tmux session named 'logic' starting in the base directory
tmux new-session -d -s logic -c "$log_base_dir"

# Step 1: First update the main branch to get latest changes
tmux send-keys -t logic "cd $log_base_dir" C-m
tmux send-keys -t logic "git switch main && git pull --rebase" C-m

# Step 2: Navigate to the teoreticke-ain directory
tmux send-keys -t logic "cd $log_base_dir/$prakt_dir/$selected_branch" C-m

# Step 3: Check out the selected branch
tmux send-keys -t logic "git switch $selected_branch" C-m

# Step 4: Pull the latest changes
tmux send-keys -t logic "git pull --rebase" C-m

# Step 5: Clear the screen for a clean workspace
tmux send-keys -t logic "clear" C-m

tmux attach -t logic
