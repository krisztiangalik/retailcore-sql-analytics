# Daily Sales Availability Check

## Business requirement
The management wants to review the previous day's sales performance by sotre every morning. 

The report should include:
    - daily revenue by store,
    - number of sales by store,
    - data availability / data quality status

The report is considered reliable only if:
    - every store has submitted data for the previous day,
    - there are no duplicate sales,
    - every sale has at least one sale item

## Grain
1 row = 1 store + 1 reporting date

## Source tables and fields
### stores
    - store_id,
    - store_name
### sales
    - sale_id,
    - store_id,
    - sale_datetime
### sale_items
    - sale_item_id,
    - sale_id,
    - quantity,
    - unit_price,
    - discount_amount

## Data quality rules
    - Every store must have at least one sale for the reporting date
    - sale_id must be unique
    - Every sale must have at least one corresponding sale_item
    - Daily revenue must not be negative

## Expected results
    - store_name,
    - report_date,
    - sales_count,
    - daily_revenue,
    - missing_sales_data_flag,
    - duplicate_sale_flag,
    - missing_sale_item_flag
    - availability_status

## SQL implementation plan

1. daily_sales
   - calculate daily revenue by store
   - count distinct sales
   - grain: 1 row = 1 store + 1 report date

2. duplicate_sale_ids
   - identify duplicate sale_id values for the report date

3. duplicate_sales
   - convert duplicate detection to store-level flag

4. missing_sale_items
   - identify stores with sales that have no sale_items

5. final output
   - keep all stores using LEFT JOIN
   - create data quality flags
   - derive overall availability_status

## Validation status

- Daily revenue logic: completed
- Sales count validation: completed
- Duplicate sale check: completed
- Missing sale item check: completed
- Missing store data check: completed
- Final availability status: completed