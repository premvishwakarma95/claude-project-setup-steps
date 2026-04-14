#!/bin/bash
# Auto-format after Claude edits a file.
FILE="$1"
if [[ "$FILE" =~ \.(ts|tsx|js|jsx)$ ]]; then
  npx prettier --write "$FILE" 2>/dev/null
  npx eslint --fix "$FILE" --quiet 2>/dev/null
fi
exit 0
