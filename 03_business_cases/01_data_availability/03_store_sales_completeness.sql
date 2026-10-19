WITH daily_store_sales AS (
    SELECT  sal.store_id,
            sto.store_name,
            sal.sale_datetime::date AS report_date,
            COUNT (DISTINCT sal.sale_id) AS sales_count,
            SUM (sai.quantity) AS products_sold,
            SUM (sai.quantity * sai.unit_price - sai.discount_amount) AS daily_revenue
    FROM sales AS sal
    JOIN stores AS sto
        ON sal.store_id = sto.store_id
    LEFT JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
    GROUP BY sal.store_id, sto.store_name, sal.sale_datetime::date
),
historical_average AS (
    SELECT
        store_id,
        AVG(daily_sales_count) AS historical_average
    FROM (
        SELECT
            store_id,
            sale_datetime::date AS sale_date,
            COUNT(DISTINCT sale_id) AS daily_sales_count
        FROM sales
        WHERE sale_datetime::date < DATE '2026-05-08'
        GROUP BY
            store_id,
            sale_datetime::date
    ) AS daily_history
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
        dss.sales_count,
        dss.products_sold,
        dss.daily_revenue,
        ha.historical_average,
        CASE WHEN dss.store_id IS NULL THEN 1
        ELSE 0
        END AS missing_sales_flag,
        COALESCE(msi.missing_sale_item_flag,0) AS missing_sale_item_flag,
        CASE WHEN dss.sales_count < ha.historical_average*0.5 THEN 1
        ELSE 0
        END AS low_sales_flag,
        CASE WHEN dss.store_id IS NOT NULL
            AND COALESCE(msi.missing_sale_item_flag,0) = 0
            AND dss.sales_count > ha.historical_average*0.5
        THEN 'OK'
        ELSE 'CHECK' 
        END AS availability_status
FROM stores AS sto
LEFT JOIN daily_store_sales AS dss
    ON sto.store_id = dss.store_id
LEFT JOIN historical_average AS ha
    ON sto.store_id = ha.store_id
LEFT JOIN missing_sale_items AS msi
    ON sto.store_id = msi.store_id
;
