---
name: stock-report
argument-hint: [warehouse-id]
---

Generate a stock report for warehouse $ARGUMENTS:
1. Query current `on_hand` per SKU for the warehouse (workspace-scoped)
2. Include reorder point, supplier, last movement date
3. Flag SKUs below reorder point as LOW
4. Flag SKUs with zero movement in 90+ days as STALE
5. Output as a markdown table + save CSV to `./reports/`
