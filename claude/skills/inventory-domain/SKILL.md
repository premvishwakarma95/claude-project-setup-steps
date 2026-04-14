---
name: inventory-domain
description: Applies inventory domain rules and vocabulary consistently.
user-invocable: true
---

# Inventory Domain Knowledge

## Vocabulary (use these exact terms)
- **SKU** — unique product identifier per workspace
- **On-hand** — physical quantity currently in a warehouse
- **Available** — on-hand minus reserved (for unshipped orders)
- **Reorder point** — threshold that triggers a low-stock alert
- **Stock movement** — append-only record of every qty change (IN/OUT/ADJUST/TRANSFER)
- **Purchase order (PO)** — draft → submitted → approved → received → closed
- **Goods receipt** — the event that converts a PO into on-hand stock
- **Cycle count** — periodic physical recount that may create ADJUST movements

## Movement types
- `PURCHASE_IN` — from goods receipt
- `SALE_OUT` — from shipment
- `TRANSFER_OUT` / `TRANSFER_IN` — warehouse to warehouse (paired)
- `ADJUST_POS` / `ADJUST_NEG` — manual correction, requires reason code
- `RETURN_IN` / `RETURN_OUT` — customer/supplier returns

## Invariants
1. Sum of movements for (sku, warehouse) == products.on_hand
2. No movement can push on-hand below 0 unless SKU allows backorder
3. Every ADJUST movement has a reason_code and a user_id
4. Transfer is two movements in one transaction — both succeed or neither does
5. Received POs are immutable; corrections go through a new PO or adjustment

## When asked to build inventory features, always:
- Confirm which movement type applies
- Confirm which permission gates the UI entry point
- Write the service function as a transaction if it touches multiple rows
- Return the updated `on_hand` in the response so the client can update cache
