WITH    revenue AS (
    SELECT
        sto.store_name,
        pro.product_id,
        pro.product_name,
        SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_revenue
    FROM stores AS sto
    JOIN sales AS sal
        ON sto.store_id = sal.store_id
    JOIN sale_items AS sai
        ON sal.sale_id = sai.sale_id
    JOIN products AS pro
        ON sai.product_id = pro.product_id
    GROUP BY sto.store_name, pro.product_name, pro.product_id
),
        ranked_products AS (
    SELECT
        store_name,
        product_name,
        total_revenue,
        ROW_NUMBER() OVER(PARTITION BY store_name ORDER BY total_revenue DESC, product_id) AS ranking
    FROM revenue
)
SELECT  store_name,
        product_name,
        total_revenue,
        ranking
FROM ranked_products
WHERE ranking <= 3
;