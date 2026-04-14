---
paths:
  - "server/routes/**/*.ts"
  - "server/services/**/*.ts"
  - "server/middleware/**/*.ts"
---

# API Rules

- Thin controllers, fat services. Routes only: validate → call service → respond.
- Every route has: `authMiddleware` → `permissionMiddleware('<key>')` → handler
- Every body/query/params validated with Zod. Reject with 400 on failure.
- Services receive `{ workspaceId, userId }` as the first argument, always.
- Never trust the client's `workspace_id` — take it from the JWT context.
- Responses use a consistent envelope: `{ data, meta }` or `{ error }`.
- Pagination: `?page=1&limit=50`, max limit 200.
- Socket.IO emits go to room `workspace:<id>`, never global.
- Error classes: `NotFoundError`, `ForbiddenError`, `DomainError`, `ValidationError`.
  A central error handler maps them to HTTP codes.
- Idempotency keys required on PO create, stock adjust, stock transfer.
