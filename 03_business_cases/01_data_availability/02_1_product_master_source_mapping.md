# Product Master Source-to-Target Mapping

| Target field | Source table | Source field | Transformation / rule |
|---|---|---|---|
| product_id | sale_items | product_id | Direct mapping from sold items |
| product_name | products | product_name | LEFT JOIN on product_id |
| category_name | categories | category_name | LEFT JOIN through products.category_id |
| supplier_name | suppliers | supplier_name | LEFT JOIN through products.supplier_id |
| report_date | sales | sale_datetime | Cast timestamp to date and filter to reporting date |
| quantity_sold | sale_items | quantity | SUM(quantity) per product and reporting date |
| daily_revenue | sale_items | quantity, unit_price, discount_amount | SUM(quantity * unit_price - discount_amount) |
| missing_product_data_flag | sale_items + products | product_id | 1 if sold product has no matching product master record |
| missing_category_flag | products + categories | category_id | 1 if product has no valid category |
| missing_supplier_flag | products + suppliers | supplier_id | 1 if product has no valid supplier |
| invalid_price_flag | sale_items | unit_price | 1 if any unit_price is NULL or negative |
| availability_status | Derived | quality flags | OK if all flags are 0, otherwise CHECK |