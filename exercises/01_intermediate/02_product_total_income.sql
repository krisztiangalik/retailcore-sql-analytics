WITH product_income AS(
    SELECT  pr.product_name,
            SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_income
    FROM sale_items AS sai
    JOIN products AS pr
        ON sai.product_id = pr.product_id
    GROUP BY pr.product_name
)
SELECT  product_name,
        total_income,
        (SELECT
            AVG(total_income) FROM product_income) AS avg_total_income
        FROM product_income
        WHERE total_income > (SELECT AVG(total_income)
                                FROM product_income)
ORDER BY total_income DESC;