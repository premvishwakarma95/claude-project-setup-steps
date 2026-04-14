---
paths:
  - "client/src/components/**/*.tsx"
  - "client/src/pages/**/*.tsx"
  - "client/src/features/**/*.tsx"
---

# Frontend Rules (Inventory UI)

- Functional components + hooks only
- shadcn/ui for primitives, never rebuild them
- Tailwind CSS, dark mode first
- Redux Toolkit for global state, RTK Query for server state
- No prop drilling past 2 levels — lift to slice or use context
- `cn()` helper for conditional classes
- Tables use TanStack Table, virtualized when > 200 rows
- Every list view: pagination + search + filter + column sort
- Permission gating: wrap entry points in `<Can permission="...">`
  the same way existing features do — DO NOT invent a new pattern
- Forms: react-hook-form + zodResolver, share schemas with backend
- Stock numbers always formatted via `formatQty()`, money via `formatMoney()`
- Socket.IO events update RTK Query cache via `updateQueryData`
