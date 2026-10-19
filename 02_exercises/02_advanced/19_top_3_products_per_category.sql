WITH product_income AS (
    SELECT  pro.product_id,
            pro.product_name,
            cat.category_name,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_income
    FROM products AS pro
    JOIN categories AS cat
        ON pro.category_id = cat.category_id
    JOIN sale_items AS sai
        ON pro.product_id = sai.product_id
    GROUP BY pro.product_id, cat.category_name, pro.product_name
),
ranking AS (
    SELECT  category_name,
            product_name,
            total_income,
            ROW_NUMBER() OVER(PARTITION BY category_name ORDER BY total_income DESC, product_id) AS rank
    FROM product_income
)
SELECT  category_name,
        product_name,
        total_income,
        rank
FROM ranking
WHERE rank <= 3
;
