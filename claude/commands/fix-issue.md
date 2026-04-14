---
name: fix-issue
argument-hint: [issue-number]
---

Fix GitHub issue #$ARGUMENTS:
1. `gh issue view $ARGUMENTS` — read the full issue and comments
2. Locate the relevant source files (services, routes, components)
3. Write a failing test that reproduces the bug
4. Implement the minimal fix — respect all domain rules in CLAUDE.md
5. `npm test` — all green
6. `npm run lint` — clean
7. Commit: `fix(inventory): <summary> (closes #$ARGUMENTS)`
