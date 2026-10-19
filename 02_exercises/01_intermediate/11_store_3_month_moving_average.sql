WITH monthly_income AS (
    SELECT  sto.store_name,
            DATE_TRUNC('month', sal.sale_datetime) AS month,
            SUM (sai.quantity*sai.unit_price-sai.discount_amount) AS total_income
    FROM stores AS sto
    JOIN sales AS sal
        ON sto.store_id = sal.store_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    GROUP BY sto.store_name, DATE_TRUNC('month', sal.sale_datetime)
)
SELECT  store_name,
        TO_CHAR (month, 'YYYY-MM') AS month,
        total_income,
        ROUND(AVG(total_income) OVER(PARTITION BY store_name ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS three_month_moving_average
FROM monthly_income
ORDER BY store_name, month
;