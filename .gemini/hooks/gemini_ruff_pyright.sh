#!/usr/bin/env bash

# Read hook input from stdin
input=$(cat)

# Extract tool name
tool_name=$(echo "$input" | jq -r '.tool_name // empty')

# Only run for file modification tools (Write/Edit equivalent)
if [[ "$tool_name" != "write_file" && "$tool_name" != "replace" ]]; then
    echo "{}"
    exit 0
fi

# Extract file path from tool_input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

# Exit if not a Python file
if [[ ! "$file_path" =~ \.py$ ]]; then
    echo "{}"
    exit 0
fi

# Exit if file doesn't exist (safety check)
if [[ ! -f "$file_path" ]]; then
    echo "{}"
    exit 0
fi

output=""
should_alert_agent=false

# Step 1: Format with ruff (always run, silent)
if command -v ruff &>/dev/null; then
    ruff format "$file_path" &>/dev/null
fi

# Step 2: Check with basedpyright
if command -v basedpyright &>/dev/null; then
    check_output=$(basedpyright "$file_path" 2>&1)

    # Parse counts from output
    if [[ $check_output =~ ([0-9]+)\ error ]]; then
        errors="${BASH_REMATCH[1]}"
    else
        errors=0
    fi

    if [[ $check_output =~ ([0-9]+)\ warning ]]; then
        warnings="${BASH_REMATCH[1]}"
    else
        warnings=0
    fi

    # Only report if errors > 0 OR warnings > 10 (Matches your Claude settings)
    if (( errors > 0 || warnings > 10 )); then
        should_alert_agent=true
        output+="⚠ Type checking issues in $file_path: ${errors} errors, ${warnings} warnings\n"
        output+="$check_output\n"
        output+="\n👉 Please fix these type errors/warnings.\n"
    fi
fi

# Return feedback to the Gemini Agent if issues are found
if [[ "$should_alert_agent" == "true" ]]; then
    # Gemini hooks return JSON. The 'feedback' key is what the agent reads.
    jq -n --arg msg "$output" '{feedback: $msg}'
else
    echo "{}"
fi

exit 0
