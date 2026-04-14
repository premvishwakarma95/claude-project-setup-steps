---
paths:
  - "server/db/**/*.ts"
  - "server/schema/**/*.ts"
  - "drizzle/**/*.sql"
---

# Database Rules

- Drizzle ORM only, no raw SQL unless wrapped in a reviewed helper
- Every table has: `id uuid pk`, `workspace_id uuid`, `created_at`,
  `updated_at`, `deleted_at` (nullable)
- Index every `workspace_id` and every FK
- Soft delete by default — never hard delete user data
- Money: `integer` minor units, column suffix `_minor` (e.g. `cost_minor`)
- Quantities: `numeric(14,4)` for stock, `integer` for counts
- Stock mutations go through `stock_movements` append-only table.
  A trigger OR the service layer recomputes `products.on_hand`.
- Unique constraint on `(workspace_id, sku)` for products
- Unique constraint on `(workspace_id, po_number)` for purchase orders
- Transactions for any multi-table write (PO receive, stock transfer)
