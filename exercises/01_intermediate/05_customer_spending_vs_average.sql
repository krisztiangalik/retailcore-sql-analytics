WITH total_spending AS (
    SELECT  cus.customer_name,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_spending
    FROM sale_items AS sai
    JOIN sales AS sal
        ON sai.sale_id = sal.sale_id
    JOIN customers AS cus
        ON sal.customer_id = cus.customer_id
    GROUP BY cus.customer_name
),
spending_with_avg AS(
    SELECT  customer_name,
            total_spending,
            AVG(total_spending) OVER() AS avg_total_spending
    FROM total_spending
)
SELECT  customer_name,
        total_spending,
        avg_total_spending
FROM spending_with_avg
WHERE total_spending > avg_total_spending
ORDER BY total_spending DESC
;

