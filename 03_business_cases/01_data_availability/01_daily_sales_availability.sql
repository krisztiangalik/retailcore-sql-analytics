WITH daily_sales AS (
    SELECT  sal.sale_datetime::date AS report_date,
            sal.store_id,
            sto.store_name,
            COUNT (DISTINCT sal.sale_id) AS sales_count,
            SUM (sai.quantity * sai.unit_price - sai.discount_amount) AS daily_revenue
    FROM sales AS sal
    JOIN stores AS sto
        ON sal.store_id = sto.store_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
    GROUP BY sal.sale_datetime::date, sal.store_id, sto.store_name
),
duplicate_sale_ids AS (
    SELECT  store_id,
            sale_id
    FROM sales
    WHERE sale_datetime::date = DATE '2026-05-08'
    GROUP BY store_id, sale_id
    HAVING COUNT(*) > 1
),
duplicate_sales AS (
    SELECT  store_id,
            1 AS duplicate_sale_flag
    FROM duplicate_sale_ids
    GROUP BY store_id
),
missing_sale_items AS (
    SELECT  sal.store_id,
            1 AS missing_sale_item_flag
    FROM sales AS sal
    LEFT JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
        AND sai.sale_id IS NULL
    GROUP BY sal.store_id
)
SELECT  sto.store_id,
        sto.store_name,
        DATE '2026-05-08' AS report_date,
        ds.sales_count,
        ds.daily_revenue,
        CASE
            WHEN ds.store_id IS NULL THEN 1
            ELSE 0
        END AS missing_sales_data_flag,
        COALESCE (dup.duplicate_sale_flag, 0) AS duplicate_sale_flag,
        COALESCE (msi.missing_sale_item_flag, 0) AS missing_sale_items_flag,
        CASE WHEN ds.store_id IS NOT NULL
                AND COALESCE (dup.duplicate_sale_flag, 0) = 0
                AND COALESCE (msi.missing_sale_item_flag,0) = 0 THEN 'OK'
            ELSE 'CHECK'
        END AS availability_status
FROM stores AS sto
LEFT JOIN daily_sales AS ds
    ON sto.store_id = ds.store_id
LEFT JOIN duplicate_sales AS dup
    ON sto.store_id = dup.store_id
LEFT JOIN missing_sale_items as msi
    ON sto.store_id = msi.store_id
;