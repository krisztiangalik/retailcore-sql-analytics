-- monthly income by stores and months --
WITH monthly_income AS(
    SELECT  sto.store_name,
            DATE_TRUNC('month', sal.sale_datetime) AS month,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_income
    FROM sales AS sal
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    JOIN stores AS sto
        ON sal.store_id = sto.store_id
    GROUP BY sto.store_name, DATE_TRUNC('month', sal.sale_datetime)
),
previous_income AS(
    SELECT  store_name,
            month,
            total_income,
            LAG(total_income) OVER(PARTITION BY store_name ORDER BY month) AS previous_month_income
    FROM monthly_income
)
SELECT  store_name,
        TO_CHAR (month, 'YYYY-MM') AS month,
        total_income,
        previous_month_income,
        total_income - previous_month_income AS diff
FROM previous_income
ORDER BY store_name, month;