-- Total de Prodututos vendidos nos meses de abril

SELECT 
    SUM(hpp.HPPD_QUANTIDADE) as Total
FROM HPEDIDOS hp
JOIN HPEDIDOS_PRODUTOS hpp ON hp.HPDD_ID = hpp.HPPD_PDD_ID
WHERE EXTRACT(MONTH FROM hp.HPDD_DATA) = 4