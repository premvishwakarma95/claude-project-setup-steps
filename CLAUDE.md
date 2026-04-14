# Inventory Project — Brain

## What this is
A multi-warehouse inventory management system. Tracks SKUs, stock levels,
suppliers, purchase orders, stock movements, and low-stock alerts.

## Stack
- Frontend: React + Vite + Redux Toolkit, Tailwind + shadcn/ui
- Backend: Node.js + Express + Drizzle ORM
- DB: PostgreSQL (multi-tenant, workspace-scoped)
- Realtime: Socket.IO for stock updates and alerts
- Auth: JWT + role-based permissions

## Commands
- `npm run dev` — start frontend + backend in parallel
- `npm run db:push` — apply Drizzle schema
- `npm run db:studio` — open Drizzle Studio
- `npm test` — vitest
- `npm run lint` — eslint + typecheck

## Core domain rules (non-negotiable)
- Stock changes are NEVER direct UPDATEs — always write a `stock_movement` row
  and let the trigger / service recompute `on_hand`. This is the audit trail.
- Every mutation is workspace-scoped. No query may omit `workspace_id`.
- Negative stock is forbidden unless the SKU has `allow_backorder = true`.
- Purchase orders are immutable once `status = 'received'`.
- All money values use integer minor units (paise/cents), never floats.

## Permissions
Enforced server-side AND gated in the UI. Permission keys:
- `inventory.view`, `inventory.adjust`, `inventory.transfer`
- `po.create`, `po.approve`, `po.receive`
- `supplier.manage`, `warehouse.manage`, `settings.manage`

UI entry points (buttons, menu items, routes) must check permissions
the same way existing features do — no new patterns.

## Conventions
- TypeScript strict, no `any`
- Zod validates every API input
- Functions under 50 lines, files under 300
- Thin controllers, fat services, dumb components
- Commit style: `feat(inventory): ...`, `fix(po): ...`
