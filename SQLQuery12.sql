SELECT 
		product_id PRODUCT, 
		SUM(quantity) TOPLAM,
		discount

FROM sale.order_item

GROUP BY product_id, discount
ORDER BY 1,3;

SELECT product_id,SUM(quantity),discount FROM sale.order_item WHERE product_id = '2'
GROUP BY product_id, discount
