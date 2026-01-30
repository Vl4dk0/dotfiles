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

output=""
should_alert_claude=false

# Step 1: Format with ruff (always run, but don't add to output)
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

    # Only report if errors > 0 OR warnings > 10
    if (( errors > 0 || warnings > 10 )); then
        should_alert_claude=true
        output+="⚠ Type checking issues: ${errors} errors, ${warnings} warnings\n"
        output+="$check_output\n"
        output+="\n👉 Fix these type errors/warnings\n"
    fi
fi

# Only alert Claude if there are significant type issues
if [[ "$should_alert_claude" == "true" ]]; then
    echo -e "\n--- Python Auto-format & Type Check ---" >&2
    echo -e "$output" >&2
    echo -e "---------------------------------------\n" >&2
    exit 2
fi

# Silent success - ruff still formatted, but no issues to report
exit 0
