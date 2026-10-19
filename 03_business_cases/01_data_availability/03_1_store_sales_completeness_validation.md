# Store Sales Completeness - Validation

## Validation objective

The purpose of the validation is to verify that:

- every active store appears in the final report
- the output grain is one row per store and reporting date
- sales_count is calculated correctly
- products_sold is calculated correctly
- daily_revenue is calculated correctly
- stores with missing sales are detected
- sales without matching sale_items are detected
- low sales activity is flagged correctly
- availability_status is consistent with the data quality rules