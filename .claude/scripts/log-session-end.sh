#!/bin/bash
# Runs when Claude stops; appends last response summary to logs/session.log
TIMESTAMP=$(date -Iseconds)
LOG_FILE="$PWD/logs/session.log"
mkdir -p "$PWD/logs"

# Find the most recently modified JSONL transcript across all Claude projects
LATEST=$(find ~/.claude/projects -name "*.jsonl" 2>/dev/null -print0 \
  | xargs -0 ls -t 2>/dev/null \
  | head -1)

if [ -n "$LATEST" ]; then
  LAST_RESPONSE=$(python3 - "$LATEST" <<'EOF'
import sys, json

path = sys.argv[1]
last_text = None
try:
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                obj = json.loads(line)
                # Claude Code JSONL format: {type, role, message: {content: [...]}} or flat {role, content}
                msg = obj.get("message") or obj
                if msg.get("role") == "assistant":
                    content = msg.get("content", "")
                    if isinstance(content, list):
                        text = " ".join(
                            c.get("text", "") for c in content
                            if isinstance(c, dict) and c.get("type") == "text"
                        )
                    else:
                        text = str(content)
                    if text.strip():
                        last_text = text.strip()
            except Exception:
                continue
except Exception:
    pass

if last_text:
    summary = last_text[:600]
    if len(last_text) > 600:
        summary += "..."
    print(summary)
else:
    print("[no response captured]")
EOF
  )
  echo "[$TIMESTAMP] CLAUDE: $LAST_RESPONSE" >> "$LOG_FILE"
else
  echo "[$TIMESTAMP] CLAUDE: [session ended - no transcript found]" >> "$LOG_FILE"
fi

echo "---" >> "$LOG_FILE"
