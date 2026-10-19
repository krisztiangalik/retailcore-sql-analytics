# Product Master Data Availability

## Business requirement

The management wants to review the products sold on the previous day every morning.

The report should include:
- sold products
- daily revenue by product
- data availability / data quality status

The report is considered reliable only if:
- every sold sale_item has a valid product_id
- every sold product has a corresponding product master record
- every product has a valid category
- every product has a valid supplier

## Grain

1 row = 1 product + 1 reporting date + data quality status

## Source tables and fields

### products
- product_id
- product_name
- category_id
- supplier_id

### categories
- category_id
- category_name

### suppliers
- supplier_id
- supplier_name

### sale_items
- sale_item_id
- sale_id
- product_id
- quantity
- unit_price
- discount_amount

### sales
- sale_id
- sale_datetime

## Data quality rules

1. Every sale_item must contain a product_id.
2. Every sale_item.product_id must match an existing products.product_id.
3. Every sold product must have a valid category.
4. Every sold product must have a valid supplier.
5. unit_price must not be NULL or negative.

## Expected output

- product_id
- product_name
- report_date
- quantity_sold
- daily_revenue
- missing_product_data_flag
- missing_category_flag
- missing_supplier_flag
- invalid_price_flag
- availability_status