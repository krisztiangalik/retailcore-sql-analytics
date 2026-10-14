WITH stores_revenue AS (
    SELECT  
        sto.store_name,
        DATE_TRUNC ('month', sal.sale_datetime) AS month,
        SUM(sai.quantity * sai.unit_price - discount_amount) AS total_revenue
    FROM stores AS sto
    JOIN sales AS sal
        ON sto.store_id = sal.store_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    GROUP BY store_name, month
)
SELECT
    store_name,
    TO_CHAR(month, 'YYYY-MM') AS month,
    total_revenue,
    SUM(total_revenue) OVER (
                            PARTITION BY store_name
                            ORDER BY month
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulated_revenue
FROM stores_revenue
;