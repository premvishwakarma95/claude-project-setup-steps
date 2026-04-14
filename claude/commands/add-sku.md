---
name: add-sku
argument-hint: [feature-description]
---

Scaffold a new SKU-related feature: $ARGUMENTS

1. Update the Drizzle schema if needed — delegate to `migration-writer`
2. Add the Zod input schema in `shared/schemas/`
3. Add the service function in `server/services/productService.ts`
   — workspace-scoped, no direct stock writes
4. Add the Express route with permission middleware
5. Add the Redux slice action + RTK Query endpoint
6. Add the React component using shadcn/ui, gated by permission
7. Write tests via `test-writer`
8. Run `inventory-auditor` before finishing
