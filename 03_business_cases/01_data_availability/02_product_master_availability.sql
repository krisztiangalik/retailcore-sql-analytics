WITH daily_product_sales AS (
    SELECT  sai.product_id,
            sal.sale_datetime::date AS report_date,
            SUM (sai.quantity) AS quantity_sold,
            SUM (sai.quantity * sai.unit_price - sai.discount_amount) AS daily_revenue,
            MAX (CASE WHEN sai.unit_price IS NULL or sai.unit_price < 0 THEN 1
                ELSE 0
                END) AS invalid_price_flag
    FROM sale_items AS sai
    JOIN sales AS sal
        ON sai.sale_id = sal.sale_id
    WHERE sal.sale_datetime::date = DATE '2026-05-08'
    GROUP BY sai.product_id, sal.sale_datetime::date
),
master_record_check AS (
    SELECT  dps.product_id,
            pro.product_name,
            cat.category_name,
            sup.supplier_name,
            dps.report_date,
            dps.quantity_sold,
            dps.daily_revenue,
            CASE WHEN pro.product_id IS NULL THEN 1
            ELSE 0
            END AS missing_product_data_flag,
            CASE WHEN cat.category_id IS NULL THEN 1
            ELSE 0
            END AS missing_category_flag,
            CASE WHEN sup.supplier_id IS NULL THEN 1
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
)
SELECT  product_id,
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
        CASE WHEN missing_product_data_flag = 0
            AND missing_category_flag = 0
            AND missing_supplier_flag = 0
            AND invalid_price_flag = 0
        THEN 'OK'
        ELSE 'Check'
        END AS availability_status
FROM master_record_check
;