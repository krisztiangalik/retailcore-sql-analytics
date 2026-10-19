SELECT  cus.customer_id,
        cus.customer_name,
        sto.store_id,
        sto.store_name,
        SUM(
            sai.quantity*sai.unit_price-sai.discount_amount
        ) AS total_spending
FROM sale_items AS sai
JOIN sales AS sal
    ON sai.sale_id = sal.sale_id
JOIN customers AS cus
    ON sal.customer_id = cus.customer_id
JOIN stores AS sto
    ON sal.store_id = sto.store_id
GROUP BY cus.customer_id, sto.store_id
HAVING SUM(
    sai.quantity*sai.unit_price-sai.discount_amount
    ) > (
        SELECT AVG(customer_store_spending)
        FROM (
        SELECT sal2.customer_id,
        SUM (
            sai2.quantity*sai2.unit_price-sai2.discount_amount
            ) AS customer_store_spending
        FROM sales AS sal2
        JOIN sale_items AS sai2
            ON sal2.sale_id = sai2.sale_id
        WHERE sal2.store_id = sto.store_id
        GROUP BY sal2.customer_id
            ) AS store_customer_spendint
        )
ORDER BY sto.store_name, cus.customer_id
;