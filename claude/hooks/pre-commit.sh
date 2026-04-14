#!/bin/bash
# Block bad commits. Exit 2 = block, exit 0 = allow.

set -e

echo "→ Typecheck..."
npx tsc --noEmit || exit 2

echo "→ Lint changed files..."
CHANGED=$(git diff --cached --name-only | grep -E "\.(ts|tsx)$" || true)
if [ -n "$CHANGED" ]; then
  npx eslint $CHANGED --quiet || exit 2
fi

echo "→ Tests..."
npm test -- --silent --run || exit 2

echo "→ Scanning for direct stock writes..."
if git diff --cached | grep -E "UPDATE\s+products\s+SET\s+on_hand|\.on_hand\s*=" ; then
  echo "BLOCKED: direct stock mutation detected. Use stockMovementService."
  exit 2
fi

echo "→ Scanning for workspace_id omission..."
if git diff --cached | grep -E "db\.(select|update|delete).*from\(.*(products|stock|purchase_orders)" | grep -v "workspace_id" ; then
  echo "WARNING: query may be missing workspace scope. Double-check."
fi

echo "✓ All checks passed"
exit 0
