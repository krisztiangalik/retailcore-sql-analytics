SELECT  customer_id,
        customer_name,
        total_spending
FROM    (
        SELECT  cus.customer_id,
                cus.customer_name,
                SUM (sai.quantity*sai.unit_price-sai.discount_amount) AS total_spending
        FROM customers AS cus
        JOIN sales AS sal
            ON cus.customer_id = sal.customer_id
        JOIN sale_items AS sai
            ON sal.sale_id = sai.sale_id
        GROUP BY cus.customer_id, cus.customer_name
        ) AS customer_spending
WHERE total_spending >  (SELECT
                            AVG(total_spending)
                        FROM    (SELECT
                                    sal.customer_id,
                                    SUM (sai.quantity*sai.unit_price-sai.discount_amount) AS total_spending
                                FROM sales AS sal
                                JOIN sale_items AS sai
                                    ON sal.sale_id = sai.sale_id
                                GROUP BY sal.customer_id
                                ) AS avg_customer_spending
                        )
ORDER BY total_spending DESC
;