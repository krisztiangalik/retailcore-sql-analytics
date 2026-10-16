WITH customers_month AS (
    SELECT DISTINCT customer_id,
    DATE_TRUNC('month',sale_datetime) AS month
    FROM sales
),
customer_first_month AS(
    SELECT  customer_id,
    month,
    MIN(month) OVER(PARTITION BY customer_id) AS first_purchase_month
    FROM customers_month
)
returning_customers AS(
    SELECT  customer_id,
            month
    FROM customer_first_month
    WHERE month > first_purchase_month
)
SELECT  COUNT (customer_id) AS customer_number,
        TO_CHAR(month, 'YYYY-MM') AS month
FROM returning_customers
GROUP BY month
ORDER BY month;