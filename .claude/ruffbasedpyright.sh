#!/usr/bin/env bash

# Get the file path from environment variable
file_path="$CLAUDE_TOOL_INPUT_FILE_PATH"

# Exit if not a Python file
if [[ ! "$file_path" =~ \.py$ ]]; then
    exit 0
fi

# Exit if file doesn't exist
if [[ ! -f "$file_path" ]]; then
    exit 0
fi

output=""

# Step 1: Format with ruff
if command -v ruff &>/dev/null; then
    if ruff format "$file_path" 2>&1; then
        output+="✓ Formatted with ruff\n"
    else
        output+="⚠ Ruff formatting failed\n"
    fi
else
    output+="⚠ ruff not found\n"
fi

# Step 2: Check with basedpyright
if command -v basedpyright &>/dev/null; then
    check_output=$(basedpyright "$file_path" 2>&1)

    # Check if there are errors/warnings
    if echo "$check_output" | grep -q "error\|warning"; then
        output+="⚠ Type checking issues found:\n"
        output+="$check_output\n"
    else
        output+="✓ No type errors (basedpyright)\n"
    fi
else
    output+="⚠ basedpyright not found\n"
fi

# Output results
if [[ -n "$output" ]]; then
    echo -e "\n--- basedpyright output ---"
    echo -e "$output"
    echo -e "---------------------------\n"
fi

exit 0
