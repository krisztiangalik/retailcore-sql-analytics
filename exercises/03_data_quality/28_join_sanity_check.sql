SELECT
    COUNT(*) AS rows_after_join,
    COUNT(DISTINCT sal.sale_id) AS distinct_sales_after_join
FROM sales AS sal
JOIN sale_items AS sai
    ON sal.sale_id = sai.sale_id;

SELECT
    COUNT(*) AS original_sales_count
FROM sales;