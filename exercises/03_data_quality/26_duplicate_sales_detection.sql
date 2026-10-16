SELECT sale_id,
		COUNT (sale_id) AS count
FROM sales s 
GROUP BY sale_id
HAVING COUNT (sale_id) > 1