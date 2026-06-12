#!/bin/bash
# Logs every user prompt to logs/session.log
TIMESTAMP=$(date -Iseconds)
LOG_FILE="$PWD/logs/session.log"
mkdir -p "$PWD/logs"

# Sanitize prompt for single-line logging (collapse newlines)
PROMPT=$(echo "${CLAUDE_USER_PROMPT}" | tr '\n' ' ')

echo "[$TIMESTAMP] USER: $PROMPT" >> "$LOG_FILE"
