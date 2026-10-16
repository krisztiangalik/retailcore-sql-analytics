WITH current_revenue AS (
    SELECT  sto.store_name,
            DATE_TRUNC ('month', sal.sale_datetime) AS month,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_revenue
    FROM stores AS sto
    JOIN sales AS sal
        ON sto.store_id = sal.store_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    GROUP BY store_name, DATE_TRUNC ('month', sal.sale_datetime)
),
previous_incomes AS (
    SELECT  store_name,
            month,
            total_revenue,
            LAG (total_revenue,1) OVER (PARTITION BY store_name ORDER BY month) AS previous_month_income,
            LAG (total_revenue,2) OVER (PARTITION BY store_name ORDER BY month) AS previous_previous_month_income
    FROM current_revenue
)
SELECT  DISTINCT store_name
FROM previous_incomes
WHERE previous_month_income > total_revenue
    AND previous_previous_month_income > previous_month_income
;