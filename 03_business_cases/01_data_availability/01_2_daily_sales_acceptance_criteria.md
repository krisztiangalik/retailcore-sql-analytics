# Acceptance Criteria

1. Every active store must appear in the daily report.
2. Each store must have a report_date equal to the selected reporting date.
3. sales_count must represent the number of distinct sales per store.
4. daily_revenue must equal:
   SUM(quantity * unit_price - discount_amount)
   for all sale_items belonging to sales on the reporting date.
5. No duplicate sale_id may exist for the reporting date.
6. Every sale must have at least one matching sale_item.
7. If any data quality rule fails, availability_status must be CHECK.
8. availability_status may be OK only when all data quality flags are 0.