SELECT
    (SELECT COUNT(*) FROM sales) AS original_sales_count,
    COUNT(*) AS rows_after_join,
    COUNT(DISTINCT sal.sale_id) AS distinct_sales_after_join,
    (SELECT COUNT(*) FROM sales) - COUNT(DISTINCT sal.sale_id) AS missing_sales_count,
    CASE
    WHEN (SELECT COUNT(*) FROM sales)
         = COUNT(DISTINCT sal.sale_id)
    THEN 'OK'
    ELSE 'CHECK'
END AS validation_status
FROM sales AS sal
JOIN sale_items AS sai
    ON sal.sale_id = sai.sale_id
;