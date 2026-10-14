WITH monthly_revenue AS (
    SELECT  sto.store_name,
            DATE_TRUNC('month', sal.sale_datetime) AS month,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_revenue
    FROM sale_items AS sai
    JOIN sales AS sal
        ON sai.sale_id = sal.sale_id
    JOIN stores AS sto
        ON sal.store_id = sto.store_id
    GROUP BY sto.store_name, DATE_TRUNC('month', sal.sale_datetime)
),
revenue_with_previous AS (
    SELECT  store_name,
            month,
            total_revenue,
            LAG(total_revenue) OVER(PARTITION BY store_name ORDER BY month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT  store_name,
        TO_CHAR(month, 'YYYY-MM') AS month,
        total_revenue,
        previous_month_revenue
FROM revenue_with_previous
ORDER BY store_name, month
;