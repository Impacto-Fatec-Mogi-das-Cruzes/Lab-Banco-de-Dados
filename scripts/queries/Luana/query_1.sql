-- Quantidade de Pedidos realizados por cada mês
SELECT 
EXTRACT(month FROM p.PDD_DATA) AS "Mês",
COUNT(p.PDD_ID) AS "Quantidade de Pedidos"
FROM PEDIDOS p
GROUP BY EXTRACT(month FROM p.PDD_DATA);