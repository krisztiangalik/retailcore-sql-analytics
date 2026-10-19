# Acceptance Criteria

1. Every active store must appear in the report for the selected reporting date.

2. The report must contain exactly one row per store and reporting date.

3. sales_count must equal the number of distinct sales for the store on the reporting date.

4. products_sold must equal the sum of quantity from all sale_items belonging to the store's sales on the reporting date.

5. daily_revenue must equal:
   SUM(quantity * unit_price - discount_amount)
   for all sale_items belonging to the store's sales on the reporting date.

6. Every reported sale must have at least one matching sale_item.

7. missing_sales_flag must be 1 if the store has no sales on the reporting date.

8. missing_sale_item_flag must be 1 if at least one sale has no matching sale_item.

9. low_sales_flag must be 1 if:
   sales_count < historical_average * 0.5

10. availability_status must be CHECK if any data quality rule fails.

11. availability_status may be OK only if all data quality flags are 0.

## Assumption

All records in the stores table represent active stores.