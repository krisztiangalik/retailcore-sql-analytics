# Store Sales Completeness

## Business requirement

The management wants to verify that all active stores submitted complete sales data for the previous day.

The report should include:
- active stores
- sales count for each active store
- number of products sold
- daily revenue

The report is considered reliable only if:
- every active store has sufficient data to calculate the required metrics
- every active store has at least one sale on the reporting date
- every reported sale has at least one valid sale_item
- unusually low sales activity is flagged for review

A store is considered unusually low if:

low_sales_flag = 1 when sales_count < historical_average * 0.5

Historical average:
The store's average daily sales count before the reporting date.

## Grain

1 row = 1 store + 1 reporting date

## Source tables and fields

### stores
- store_id
- store_name

### sales
- sale_id
- store_id
- sale_datetime

### sale_items
- sale_item_id
- sale_id
- product_id
- quantity
- unit_price
- discount_amount

## Data quality rules

- Every active store must appear in the daily report.
- Every active store must have at least one sale on the reporting date.
- Every reported sale must have at least one matching sale_item.
- Sales count must be compared with the store's historical average.
- Stores with unusually low sales activity must be flagged for review.

## Expected output

- store_id
- store_name
- report_date
- sales_count
- products_sold
- daily_revenue
- historical_average
- missing_sales_flag
- missing_sale_items_flag
- low_sales_flag
- availability_status

## Assumption

All records in the stores table represent active stores.

1. CTE: daily_store_sales
   → daily sales_count, products_sold, daily_revenue by stores

2. CTE: historical_average
   → historical average by stores

3. CTE: missing_sale_items_check

Final query
   → stores is the base
   → LEFT JOIN with all the CTEs
   → missing_sales_flag
   → low_sales_flag
   → missing_sale_items_flag
   → availability_status