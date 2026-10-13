SELECT  st.store_name,
        SUM(sai.quantity*sai.unit_price-sai.discount_amount) AS total_income
FROM sales AS sa
JOIN stores AS st
    ON sa.store_id = st.store_id
JOIN sale_items AS sai
    ON sa.sale_id = sai.sale_id
GROUP BY st.store_name
ORDER BY total_income DESC
LIMIT 1;