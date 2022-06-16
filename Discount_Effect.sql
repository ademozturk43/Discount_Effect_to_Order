SELECT 
PRODUCT,
CASE WHEN NOP > NON THEN 'Pos�t�ve'
	 ELSE 'Negat�ve' END AS Discount_Effect
FROM

	(
	SELECT 
	B.PRODUCT,
	COUNT(CASE WHEN FARK = 'Pos�t�ve' THEN 1 END) AS NOP,
	COUNT(CASE WHEN FARK = 'Negat�ve' THEN 1 END) AS NON
	FROM 
	(
		SELECT
		A.PRODUCT,
		CASE WHEN (LEAD(A.TOPLAM) OVER (PARTITION BY A.PRODUCT ORDER BY A.discount) - A.TOPLAM) <=0 THEN 'Negat�ve'
			 WHEN (LEAD(A.TOPLAM) OVER (PARTITION BY A.PRODUCT ORDER BY A.discount) - A.TOPLAM) IS NULL THEN NULL         
			 ELSE 'Pos�t�ve' END AS FARK
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



