WITH previous_purchase_datetime AS (
    SELECT  cus.customer_id,
            cus.customer_name,
            sal.sale_id,
            sal.sale_datetime,
            LAG(sal.sale_datetime) OVER(PARTITION BY cus.customer_id ORDER BY sal.sale_datetime) AS previous_sale_datetime
    FROM sales AS sal
    JOIN customers AS cus
        ON sal.customer_id = cus.customer_id
)
SELECT  customer_name,
        COUNT (sale_id) AS number_of_purchases,
        MAX (sale_datetime) AS last_purchase,
        CASE
            WHEN COUNT(sale_id) = 1 THEN NULL
            ELSE ROUND(
                    AVG(
                        EXTRACT(EPOCH FROM (sale_datetime - previous_sale_datetime)) / 86400
                        ),2
                    )
        END AS avg_days_between_purchases,
        CASE
            WHEN COUNT(sale_id) = 1 THEN 'First-time customer'
            ELSE 'Returning customer'
        END AS customer_status
FROM previous_purchase_datetime
GROUP BY customer_name
;