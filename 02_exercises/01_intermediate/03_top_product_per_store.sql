WITH sum_rev AS (
    SELECT  sto.store_name,
            pro.product_name,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_income
    FROM sales AS sal
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    JOIN stores AS sto
        ON sal.store_id = sto.store_id
    JOIN products AS pro
        ON sai.product_id = pro.product_id
    GROUP BY sto.store_name, pro.product_name
),
ranked_products AS (
    SELECT  store_name,
            product_name,
            total_income,
            RANK() OVER(PARTITION BY store_name ORDER BY total_income DESC) AS product_rank
    FROM sum_rev
)
SELECT *
FROM ranked_products
WHERE product_rank = 1;