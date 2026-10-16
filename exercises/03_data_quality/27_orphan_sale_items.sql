SELECT  sai.sale_item_id AS sales_items_id,
		sai.sale_id AS sales_id
FROM sale_items AS sai
LEFT JOIN sales AS sal
    ON sai.sale_id = sal.sale_id
WHERE sal.sale_id IS NULL
;