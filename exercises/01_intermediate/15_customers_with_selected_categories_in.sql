SELECT  cus.customer_id,
        cus.customer_name
FROM customers AS cus
WHERE cus.customer_id IN    (
                            SELECT  sal.customer_id
                            FROM sales AS sal
                            JOIN sale_items AS sai
                                ON sal.sale_id = sai.sale_id
                            JOIN products AS pro
                                ON sai.product_id = pro.product_id
                            JOIN categories AS cat
                                ON pro.category_id = cat.category_id
                            WHERE cat.category_name IN ('Beverages', 'Snacks')
                            )
ORDER BY cus.customer_id
;