#!/bin/bash
# Bootstrap a new project from the claude-template.
# Usage: new-project.sh <name> <goal> <stack> <github: public|private|skip>
set -e

NAME="$1"
GOAL="$2"
STACK="$3"
GITHUB="$4"

TEMPLATE_DIR="$HOME/Library/CloudStorage/GoogleDrive-bhsiao123@gmail.com/My Drive/dev/claude-template"
TARGET_DIR="$HOME/dev/$NAME"

if [ -z "$NAME" ]; then
  echo "Usage: $0 <name> <goal> <stack> <github: public|private|skip>"
  exit 1
fi

if [ -d "$TARGET_DIR" ]; then
  echo "Error: $TARGET_DIR already exists."
  exit 1
fi

echo "Creating project at $TARGET_DIR..."
cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

# Clear the logs
rm -f "$TARGET_DIR/logs/session.log"
touch "$TARGET_DIR/logs/.gitkeep"

# Write project-specific CLAUDE.md
cat > "$TARGET_DIR/CLAUDE.md" <<CLAUDEMD
# $NAME

## Goal
$GOAL

## Stack
$STACK

## Session Log
All prompts and summarized responses are automatically appended to \`logs/session.log\`.

## Getting started
- Use \`/new-project\` to bootstrap another project from the template.
CLAUDEMD

# Init git
cd "$TARGET_DIR"
git init -q
git add .
git commit -q -m "init: bootstrap from claude-template"

# GitHub
if [ "$GITHUB" = "public" ] || [ "$GITHUB" = "private" ]; then
  if ! command -v gh &>/dev/null; then
    echo "Warning: gh CLI not found — skipping GitHub repo creation."
    echo "Install with: brew install gh && gh auth login"
  else
    gh repo create "$NAME" "--$GITHUB" --source=. --remote=origin --push
    echo "GitHub repo created: $(gh repo view "$NAME" --json url -q .url)"
  fi
fi

echo ""
echo "Done! Your new project is ready:"
echo "  cd ~/dev/$NAME"
echo "  claude"
