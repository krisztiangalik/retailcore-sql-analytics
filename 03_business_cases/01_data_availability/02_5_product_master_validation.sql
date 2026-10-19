-- 1. Grain validation
-- Expected result: 0 rows
-- One row should represent one product + one report_date.

WITH daily_product_sales AS (
    SELECT
        sai.product_id,
        sal.sale_datetime::date AS report_date,
        SUM(sai.quantity) AS quantity_sold,
        SUM(sai.quantity * sai.unit_price - sai.discount_amount) AS daily_revenue,
        MAX(
            CASE
                WHEN sai.unit_price IS NULL OR sai.unit_price < 0 THEN 1
                ELSE 0
            END
        ) AS invalid_price_flag
    FROM sale_items AS sai
    JOIN sales AS sal
        ON sai.sale_id = sal.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
    GROUP BY
        sai.product_id,
        sal.sale_datetime::date
),
master_record_check AS (
    SELECT
        dps.product_id,
        pro.product_name,
        cat.category_name,
        sup.supplier_name,
        dps.report_date,
        dps.quantity_sold,
        dps.daily_revenue,
        CASE
            WHEN pro.product_id IS NULL THEN 1
            ELSE 0
        END AS missing_product_data_flag,
        CASE
            WHEN cat.category_id IS NULL THEN 1
            ELSE 0
        END AS missing_category_flag,
        CASE
            WHEN sup.supplier_id IS NULL THEN 1
            ELSE 0
        END AS missing_supplier_flag,
        dps.invalid_price_flag
    FROM daily_product_sales AS dps
    LEFT JOIN products AS pro
        ON dps.product_id = pro.product_id
    LEFT JOIN categories AS cat
        ON pro.category_id = cat.category_id
    LEFT JOIN suppliers AS sup
        ON pro.supplier_id = sup.supplier_id
),
final_output AS (
    SELECT
        product_id,
        product_name,
        category_name,
        supplier_name,
        report_date,
        quantity_sold,
        daily_revenue,
        missing_product_data_flag,
        missing_category_flag,
        missing_supplier_flag,
        invalid_price_flag,
        CASE
            WHEN missing_product_data_flag = 0
             AND missing_category_flag = 0
             AND missing_supplier_flag = 0
             AND invalid_price_flag = 0
            THEN 'OK'
            ELSE 'CHECK'
        END AS availability_status
    FROM master_record_check
)
SELECT
    product_id,
    report_date,
    COUNT(*) AS row_count
FROM final_output
GROUP BY
    product_id,
    report_date
HAVING COUNT(*) > 1;

-- 2. Sold product coverage validation
-- Expected result: the two counts should be equal.

SELECT
    COUNT(DISTINCT sai.product_id) AS source_product_count
FROM sale_items AS sai
JOIN sales AS sal
    ON sai.sale_id = sal.sale_id
WHERE sal.sale_datetime::date = DATE '2026-05-08';

SELECT
    COUNT(DISTINCT product_id) AS output_product_count
FROM final_output;

-- Or

-- Expected result: 0 rows

SELECT DISTINCT
    sai.product_id
FROM sale_items AS sai
JOIN sales AS sal
    ON sai.sale_id = sal.sale_id
WHERE sal.sale_datetime::date = DATE '2026-05-08'
EXCEPT
SELECT
    product_id
FROM final_output;

-- 3. Revenue reconciliation
-- Expected result: source_revenue = output_revenue

-- Expected result: revenue_difference = 0

SELECT
    (
        SELECT
            SUM(sai.quantity * sai.unit_price - sai.discount_amount)
        FROM sale_items AS sai
        JOIN sales AS sal
            ON sai.sale_id = sal.sale_id
        WHERE sal.sale_datetime::date = DATE '2026-05-08'
    )
    -
    (
        SELECT
            SUM(daily_revenue)
        FROM final_output
    ) AS revenue_difference;

-- 4. Quality flag validation
-- Review all rows where at least one quality flag failed.
-- To check that the flags are working corretly, it would be better to make an invalid record in the database for checking.
-- For exampla with: unit_price = -100; for the missing_supplier the NOT NULL and the FOREIGN KEY will ensure the good quality;
-- for the category_ id is the same as the supplier_id

SELECT
    product_id,
    product_name,
    category_name,
    supplier_name,
    report_date,
    missing_product_data_flag,
    missing_category_flag,
    missing_supplier_flag,
    invalid_price_flag,
    availability_status
FROM final_output
WHERE missing_product_data_flag = 1
   OR missing_category_flag = 1
   OR missing_supplier_flag = 1
   OR invalid_price_flag = 1;

-- 8. Availability status consistency check
-- Expected result: 0 rows
-- No row may be OK if any quality flag is 1.

SELECT
    product_id,
    report_date,
    missing_product_data_flag,
    missing_category_flag,
    missing_supplier_flag,
    invalid_price_flag,
    availability_status
FROM final_output
WHERE availability_status = 'OK'
  AND (
      missing_product_data_flag = 1
      OR missing_category_flag = 1
      OR missing_supplier_flag = 1
      OR invalid_price_flag = 1
  );

-- Expected result: 0 rows
-- No row may be CHECK if all quality flags are 0.

SELECT
    product_id,
    report_date,
    missing_product_data_flag,
    missing_category_flag,
    missing_supplier_flag,
    invalid_price_flag,
    availability_status
FROM final_output
WHERE availability_status = 'CHECK'
  AND missing_product_data_flag = 0
  AND missing_category_flag = 0
  AND missing_supplier_flag = 0
  AND invalid_price_flag = 0;