#!/bin/bash
# Finds the next unchecked task in CLAUDE.md roadmap
# Usage: ./next-task.sh [path-to-claude-md]

CLAUDE_MD="${1:-CLAUDE.md}"

if [ ! -f "$CLAUDE_MD" ]; then
  echo "ERROR: $CLAUDE_MD not found"
  exit 1
fi

NEXT=$(grep -n '^\- \[ \]' "$CLAUDE_MD" | head -1)

if [ -z "$NEXT" ]; then
  echo "DONE: All tasks completed"
  exit 0
fi

LINE_NUM=$(echo "$NEXT" | cut -d: -f1)
TASK=$(echo "$NEXT" | cut -d: -f2- | sed 's/^- \[ \] //')

echo "NEXT_TASK_LINE=$LINE_NUM"
echo "NEXT_TASK=$TASK"

# Count progress
TOTAL=$(grep -c '^\- \[.\]' "$CLAUDE_MD")
DONE=$(grep -c '^\- \[x\]' "$CLAUDE_MD")
echo "PROGRESS=$DONE/$TOTAL"
