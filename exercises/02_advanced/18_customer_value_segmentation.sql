WITH customer_spending AS   (
    SELECT  cus.customer_id,
            cus.customer_name,
            SUM (sai.quantity*sai.unit_price-sai.discount_amount) AS total_spending
    FROM customers AS cus
    JOIN sales AS sal
        ON cus.customer_id = sal.customer_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    GROUP BY cus.customer_id, cus.customer_name
                            )
SELECT  customer_id,
        customer_name,
        total_spending,
        CASE
            WHEN total_spending < 5000 THEN 'Low Value'
            WHEN total_spending < 10000 THEN 'Medium Value'
            ELSE 'High Value'
        END AS Ratings
FROM customer_spending
;