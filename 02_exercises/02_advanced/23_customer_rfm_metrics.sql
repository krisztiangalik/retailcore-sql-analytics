SELECT  sal.customer_id,
        cus.customer_name,
        DATE '2026-06-01' - (MAX (sal.sale_datetime)::date) AS days_after_last_purchase,
        COUNT (DISTINCT sal.sale_id) AS numbers_of_purchases,
        SUM (sai.quantity * sai.unit_price - sai.discount_amount) AS total_purchase_amount
FROM sales AS sal
JOIN customers AS cus
    ON sal.customer_id = cus.customer_id
JOIN sale_items AS sai
    ON sal.sale_id = sai.sale_id
GROUP BY sal.customer_id, cus.customer_name
ORDER BY sal.customer_id
;
