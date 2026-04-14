# claude-project-setup-steps

## Learn from here.
https://resources.leadgenman.com/ClaudeFolderSetup?fbclid=PAT01DUARGGGRleHRuA2FlbQIxMABzcnRjBmFwcF9pZA81NjcwNjczNDMzNTI0MjcAAadsv7WE0tve1CXehDWPPfx4vu06O-DvidwKdcD18bhSmeRjEBYVbfTHKYr85Q_aem_v7a0JAI8t8bsMbvROgGDpA


# How to Learn This `.claude` Setup

Read the files in this exact order. Each one builds on the last. Don't skip.
Total time: ~30 minutes to read, ~1 hour to customize for your project.

---

## Step 0 — Install Claude Code (skip if you already have it)

```bash
npm install -g @anthropic-ai/claude-code
```

Then in your project root:
```bash
claude
```

---

## Step 1 — `CLAUDE.md` (the brain) 🧠

**Read first. This is the most important file.**

Location: project root (not inside `.claude/`)

Why first: Claude loads this on **every single session**. It's the one file
that's always in context. Everything else is conditional.

What to look for:
- The **Stack** section — tells Claude what tools you use
- The **Core domain rules** — the non-negotiables Claude must never break
- The **Conventions** — how you like code written

👉 **Your job:** Edit the Stack and Commands sections to match your real
project. If your stack is different, change it now before going further.

---

## Step 2 — `.claude/settings.json` (the control center) ⚙️

**Read second. This wires everything together.**

Why second: This file decides what Claude is allowed to do and which hooks
run when. Until you understand this, nothing else makes sense.

What to look for:
- `permissions.allow` — commands Claude can run without asking
- `permissions.deny` — commands Claude will NEVER run (safety net)
- `hooks` — scripts that run before/after tool use
- `model` — which Claude model is used

👉 **Your job:** Add any project-specific commands you want pre-approved
(e.g. your own npm scripts). Keep the deny list strict.

---

## Step 3 — `.claude/rules/` (context-aware instructions) 📋

**Read third. These load automatically based on what file you're editing.**

Read in this order:
1. `database.md` — read first, it's the foundation
2. `api.md` — builds on the DB layer
3. `frontend.md` — consumes the API

Why this order: Inventory is a backend-heavy domain. Data model → API → UI
is how the system is actually built, so that's how you should understand it.

Key thing to understand: the `paths:` frontmatter at the top. Claude only
loads `frontend.md` when you're editing files matching those globs. This
keeps the context window lean.

👉 **Your job:** Adjust the `paths:` globs to match your actual folder
structure. If your frontend lives in `web/` not `client/`, fix it.

---

## Step 4 — `.claude/skills/inventory-domain/SKILL.md` 📚

**Read fourth. This is your domain dictionary.**

Why now: Rules tell Claude *how* to code. Skills tell Claude *what the
domain means*. After you understand the rules, the vocabulary makes sense.

What to look for:
- **Vocabulary** — the exact terms Claude should use (SKU, on-hand, etc.)
- **Movement types** — the state machine for stock changes
- **Invariants** — rules that can never be broken

👉 **Your job:** If your business uses different terms (e.g. "lot" instead
of "batch"), rename them here. Consistency matters.

---

## Step 5 — `.claude/agents/` (your AI team) 👥

**Read fifth. Now you meet your specialists.**

Read in this order:
1. `inventory-auditor.md` — the domain guardian, most specific to you
2. `code-reviewer.md` — general quality gate
3. `migration-writer.md` — for when you change the schema
4. `test-writer.md` — for when you add tests
5. `debugger.md` — for when something breaks

Why agents come after rules: agents USE the rules. You need to know the
rules first to understand what each agent is enforcing.

How to invoke an agent manually in Claude Code:
```
> use the inventory-auditor to check my recent changes
```

Or Claude will delegate to them automatically when relevant.

👉 **Your job:** Don't edit these yet. Use them for a week first, then
tune based on what they miss.

---

## Step 6 — `.claude/commands/` (slash commands) ⚡

**Read sixth. Shortcuts for repeated workflows.**

Read in this order:
1. `fix-issue.md` — simplest, good starting point
2. `add-sku.md` — the full vertical-slice example
3. `stock-report.md` — a utility command

How to use:
```
/fix-issue 42
/add-sku "add barcode scanning to product form"
/stock-report warehouse-uuid-here
```

The `$ARGUMENTS` placeholder gets replaced with whatever you type after.

👉 **Your job:** Create one new command for YOUR most repeated workflow.
Start with something small you type 5+ times a week.

---

## Step 7 — `.claude/hooks/` (enforcement scripts) 🛡️

**Read last. These are the safety net.**

Read in this order:
1. `lint-on-save.sh` — simple, low-risk
2. `pre-commit.sh` — the important one, blocks bad commits

Why last: hooks silently run in the background. You only need to
understand them when something gets blocked and you need to debug it.

Key concept: **exit code 2 = block the action**, exit code 0 = allow.

👉 **Your job:** Make sure they're executable:
```bash
chmod +x .claude/hooks/*.sh
```

Test `pre-commit.sh` by running it manually before trusting it.

---

## Quick Mental Model

```
CLAUDE.md          → always loaded   → "who I am, what I'm building"
settings.json      → always loaded   → "what Claude can do"
rules/*.md         → conditional     → "how to write code for THIS folder"
skills/*/SKILL.md  → situational     → "what the domain means"
agents/*.md        → on demand       → "specialists I can call"
commands/*.md      → on demand       → "shortcuts I can run"
hooks/*.sh         → automatic       → "rules that can't be broken"
```

---

## Your First Session Checklist

After reading everything above:

- [ ] Edit `CLAUDE.md` stack + commands to match reality
- [ ] Run `chmod +x .claude/hooks/*.sh`
- [ ] Adjust `paths:` globs in `rules/*.md` to match your folders
- [ ] Rename domain terms in `skills/inventory-domain/SKILL.md` if needed
- [ ] Open Claude Code, ask: *"read CLAUDE.md and tell me what project this is"*
- [ ] If it gets it right, you're set up correctly
- [ ] Try `/fix-issue 1` on a real issue to test the workflow
- [ ] Let `inventory-auditor` review your next PR

---

## When Things Go Wrong

**Claude isn't following a rule** → the rule's `paths:` glob probably doesn't
match the file you're editing. Fix the glob.

**A hook blocks something it shouldn't** → read the hook's script, the exit
codes tell you which check failed.

**An agent gives bad advice** → the agent's prompt is too vague. Add more
specific steps or examples.

**Claude ignores `CLAUDE.md`** → the file is probably too long. Keep it
under ~200 lines. Move details into `rules/` or `skills/`.

---

## Further Reading (official docs)

- Claude Code docs: https://docs.claude.com/en/docs/claude-code
- Skills guide: https://docs.claude.com/en/docs/claude-code/skills
- Hooks reference: https://docs.claude.com/en/docs/claude-code/hooks

That's it. Start with Step 1 and don't skip ahead.
