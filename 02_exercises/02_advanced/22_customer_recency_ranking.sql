WITH customer_last_purchase AS (
    SELECT  sal.customer_id,
            cus.customer_name,
            MAX(sal.sale_datetime) AS last_purchase
    FROM sales AS sal
    JOIN customers AS cus
        ON sal.customer_id = cus.customer_id
    GROUP BY sal.customer_id, cus.customer_name
)
SELECT  customer_id,
		customer_name,
        last_purchase,
        DATE '2026-06-01' - last_purchase :: date AS days_after_last_purchase,
        DENSE_RANK() OVER(ORDER BY DATE '2026-06-01' - last_purchase:: date) AS recency_rank
FROM customer_last_purchase
ORDER BY recency_rank, customer_name
;