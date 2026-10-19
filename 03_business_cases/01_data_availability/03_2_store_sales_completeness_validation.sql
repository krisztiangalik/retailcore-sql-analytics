-- the output grain is one row per store and reporting date
WITH final_output AS(
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
)
SELECT  store_id,
        report_date,
        COUNT (*) AS row_count
FROM final_output
GROUP BY store_id, report_date
HAVING COUNT(*) > 1
;

-- 2. Store coverage validation
-- Expected result: 0 rows
-- Change the main querry from the previous querry with the below querry:

SELECT
    sto.store_id,
    sto.store_name
FROM stores AS sto

EXCEPT

SELECT
    store_id,
    store_name
FROM final_output;

-- 3. Sales count validation
-- Expected result: 
-- Change the main querry from the first querry with the below querry:

source_sales_count AS (
    SELECT
        store_id,
        COUNT(DISTINCT sale_id) AS source_sales_count
    FROM sales
    WHERE sale_datetime::date = DATE '2026-05-08'
    GROUP BY store_id
)
SELECT
    fo.store_id,
    fo.sales_count,
    ssc.source_sales_count
FROM final_output AS fo
JOIN source_sales_count AS ssc
    ON fo.store_id = ssc.store_id
WHERE COALESCE(fo.sales_count, 0) <> COALESCE(ssc.source_sales_count, 0);

-- 4. Products sold validation
-- Expected result: 0 rows
-- Change the main querry from the first querry with the below querry:

source_products_sold AS (
    SELECT
        sal.store_id,
        SUM(sai.quantity) AS source_products_sold
    FROM sales AS sal
    LEFT JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
    GROUP BY sal.store_id
)
SELECT
    fo.store_id,
    fo.products_sold,
    sps.source_products_sold
FROM final_output AS fo
LEFT JOIN source_products_sold AS sps
    ON fo.store_id = sps.store_id
WHERE COALESCE(fo.products_sold, 0) <> COALESCE(sps.source_products_sold, 0);

-- 5. Daily revenue validation
-- Expected result: 0 rows
-- Change the main querry from the first querry with the below querry:

source_daily_revenue AS (
    SELECT
        sal.store_id,
        SUM(
            sai.quantity * sai.unit_price - sai.discount_amount
        ) AS source_daily_revenue
    FROM sales AS sal
    LEFT JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
    GROUP BY sal.store_id
)
SELECT
    fo.store_id,
    fo.daily_revenue,
    sdr.source_daily_revenue
FROM final_output AS fo
LEFT JOIN source_daily_revenue AS sdr
    ON fo.store_id = sdr.store_id
WHERE COALESCE(fo.daily_revenue, 0) <> COALESCE(sdr.source_daily_revenue, 0);

-- 6. Missing sale items flag validation
-- Expected result: 0 rows
-- Change the main querry from the first querry with the below querry:

source_missing_sale_items AS (
    SELECT
        sal.store_id,
        1 AS source_missing_sale_item_flag
    FROM sales AS sal
    LEFT JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
      AND sai.sale_id IS NULL
    GROUP BY sal.store_id
)
SELECT
    fo.store_id,
    fo.missing_sale_item_flag,
    COALESCE(smsi.source_missing_sale_item_flag, 0)
        AS source_missing_sale_item_flag
FROM final_output AS fo
LEFT JOIN source_missing_sale_items AS smsi
    ON fo.store_id = smsi.store_id
WHERE fo.missing_sale_item_flag <> COALESCE(smsi.source_missing_sale_item_flag, 0);

-- 7. Low sales flag validation
-- Expected result: 0 rows
-- Change the main querry from the first querry with the below querry:

SELECT
    store_id,
    sales_count,
    historical_average,
    low_sales_flag
FROM final_output
WHERE
    (
        historical_average IS NOT NULL
        AND sales_count < historical_average * 0.5
        AND low_sales_flag <> 1
    )
    OR
    (
        historical_average IS NOT NULL
        AND sales_count >= historical_average * 0.5
        AND low_sales_flag <> 0
    );

-- 8. Availability status consistency check
-- Expected result: 0 rows
-- Change the main querry from the first querry with the below querry:

SELECT
    store_id,
    report_date,
    missing_sales_flag,
    missing_sale_item_flag,
    low_sales_flag,
    availability_status
FROM final_output
WHERE availability_status = 'OK'
  AND (
      missing_sales_flag = 1
      OR missing_sale_item_flag = 1
      OR low_sales_flag = 1
  );

  -- Expected result: 0 rows

SELECT
    store_id,
    report_date,
    missing_sales_flag,
    missing_sale_item_flag,
    low_sales_flag,
    availability_status
FROM final_output
WHERE availability_status = 'CHECK'
  AND missing_sales_flag = 0
  AND missing_sale_item_flag = 0
  AND low_sales_flag = 0;