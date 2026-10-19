# Acceptance Criteria

1. Every product sold on the reporting date must have a product_id.
2. Every sold product must have a valid supplier.
3. Every sold product must have a valid category.
4. Every sold item must have a non-null and non-negative unit_price.
5. availability_status must be CHECK if any data quality rule fails.
6. availability_status may be OK only if all data quality flags are 0.