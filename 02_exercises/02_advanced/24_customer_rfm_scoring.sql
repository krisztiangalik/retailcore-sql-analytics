WITH metrics AS(
    SELECT  sal.customer_id,
            cus.customer_name,
            DATE '2026-06-01' - (MAX(sal.sale_datetime)::date) AS days_after_last_purchase,
            COUNT (DISTINCT sal.sale_id) AS number_of_sales,
            SUM (sai.quantity * sai.unit_price - sai.discount_amount) AS total_purchase_amount
    FROM sales AS sal
    JOIN customers AS cus
        ON sal.customer_id = cus.customer_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    GROUP BY sal.customer_id, cus.customer_name
)
SELECT  customer_id,
        customer_name,
        days_after_last_purchase,
        number_of_sales,
        total_purchase_amount,
        NTILE (3) OVER (ORDER BY days_after_last_purchase DESC) AS recency_score,
        NTILE (3) OVER (ORDER BY number_of_sales) AS frequency_score,
        NTILE (3) OVER (ORDER BY total_purchase_amount) AS monetary_score
FROM metrics
ORDER BY recency_score DESC, frequency_score DESC, monetary_score DESC
;