SELECT  sal.customer_id AS sales_customer_id,
		cus.customer_id AS customer_id
FROM sales AS sal
LEFT JOIN customers AS cus
    ON sal.customer_id = cus.customer_id
WHERE cus.customer_id IS NULL
;