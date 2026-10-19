# Daily Sales Source-to-Target Mapping

| Target field | Source table | Source field | Transformation / rule |
|---|---|---|---|
| store_id | stores | store_id | Direct mapping |
| store_name | stores | store_name | Direct mapping |
| report_date | sales | sale_datetime | Cast timestamp to date and filter to reporting date |
| sales_count | sales | sale_id | COUNT(DISTINCT sale_id) per store and reporting date |
| daily_revenue | sale_items | quantity, unit_price, discount_amount | SUM(quantity * unit_price - discount_amount) |
| missing_sales_data_flag | stores + daily_sales | store_id | 1 if no daily sales record exists for the store, otherwise 0 |
| duplicate_sale_flag | sales | sale_id | 1 if a sale_id occurs more than once on the reporting date |
| missing_sale_item_flag | sales + sale_items | sale_id | 1 if a sale has no matching sale_item |
| availability_status | Derived | Quality flags | OK if all quality flags are 0, otherwise CHECK |