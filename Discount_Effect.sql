SELECT 
PRODUCT,
CASE WHEN NOP > NON THEN 'Posýtýve'
	 ELSE 'Negatýve' END AS Discount_Effect
FROM

	(
	SELECT 
	B.PRODUCT,
	COUNT(CASE WHEN FARK = 'Posýtýve' THEN 1 END) AS NOP,
	COUNT(CASE WHEN FARK = 'Negatýve' THEN 1 END) AS NON
	FROM 
	(
		SELECT
		A.PRODUCT,
		CASE WHEN (LEAD(A.TOPLAM) OVER (PARTITION BY A.PRODUCT ORDER BY A.discount) - A.TOPLAM) <=0 THEN 'Negatýve'
			 WHEN (LEAD(A.TOPLAM) OVER (PARTITION BY A.PRODUCT ORDER BY A.discount) - A.TOPLAM) IS NULL THEN NULL         
			 ELSE 'Posýtýve' END AS FARK
		FROM (
			SELECT 
				DISTINCT product_id PRODUCT, 
				SUM(quantity) OVER (PARTITION BY product_id,discount ORDER BY discount ) TOPLAM,
				discount

			FROM sale.order_item
			) A
	) B

	GROUP BY PRODUCT
	) C



