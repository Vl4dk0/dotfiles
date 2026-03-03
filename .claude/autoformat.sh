#!/usr/bin/env bash

# Get the file path from stdin JSON
file_path=$(cat | jq -r '.tool_input.file_path // empty')

# Exit if not a Python file
if [[ ! "$file_path" =~ \.py$ ]]; then
    exit 0
fi

# Exit if file doesn't exist
if [[ ! -f "$file_path" ]]; then
    exit 0
fi

# Format with ruff
if command -v ruff &>/dev/null; then
    ruff format "$file_path" &>/dev/null
fi

exit 0
