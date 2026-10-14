WITH customers_month AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC('month', sale_datetime) AS month
    FROM sales
),
customer_first_month AS (
    SELECT
        customer_id,
        month,
        MIN(month) OVER (
            PARTITION BY customer_id
        ) AS first_purchase_month
    FROM customers_month
)
SELECT
    TO_CHAR(month, 'YYYY-MM') AS month,
    COUNT(*) AS active_customers,
    COUNT(*) FILTER (
        WHERE month > first_purchase_month
    ) AS returning_customers,
    ROUND(
        100.0
        * COUNT(*) FILTER (
            WHERE month > first_purchase_month
        )
        / COUNT(*),
        2
    ) AS returning_customer_rate
FROM customer_first_month
GROUP BY month
ORDER BY month;