SELECT  cus.customer_id,
        cus.customer_name
FROM customers AS cus
WHERE NOT EXISTS    (
                    SELECT 1
                    FROM sales AS sal
                    JOIN sale_items AS sai
                        ON sal.sale_id = sai.sale_id
                    JOIN products AS pro
                        ON sai.product_id = pro.product_id
                    JOIN categories AS cat
                        ON pro.category_id = cat.category_id
                    WHERE sal.customer_id = cus.customer_id
                        AND cat.category_name = 'Beverages'
                    )
ORDER BY cus.customer_name
;