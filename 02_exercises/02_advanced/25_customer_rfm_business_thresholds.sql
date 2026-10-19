WITH metrics AS (
    SELECT  sal.customer_id,
            cus.customer_name,
            DATE '2026-06-01' - (MAX(sal.sale_datetime)::date) AS days_after_last_purchase,
            COUNT (DISTINCT sal.sale_id) AS number_of_purchases,
            SUM (sai.quantity * sai.unit_price - sai.discount_amount) AS total_purchase_amount
    FROM sales AS sal
    JOIN customers AS cus
        ON sal.customer_id = cus.customer_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    GROUP BY sal.customer_id, cus.customer_name
),
scoring AS (
    SELECT  customer_id,
            customer_name,
            days_after_last_purchase,
            number_of_purchases,
            total_purchase_amount,
            CASE
                WHEN days_after_last_purchase <= 30 THEN 3
                WHEN days_after_last_purchase > 60 THEN 1
                ELSE 2
            END AS recency_score,
            CASE
                WHEN number_of_purchases >= 3 THEN 3
                WHEN number_of_purchases = 2 THEN 2
                ELSE 1
            END AS frequency_score,
            CASE
                WHEN total_purchase_amount >= 10000 THEN 3
                WHEN total_purchase_amount < 5000 THEN 1
                ELSE 2
            END AS monetary_score
    FROM metrics
)
SELECT  customer_id,
        customer_name,
        days_after_last_purchase,
        number_of_purchases,
        total_purchase_amount,
        recency_score,
        frequency_score,
        monetary_score
FROM scoring
ORDER BY recency_score DESC, frequency_score DESC, monetary_score DESC
;
