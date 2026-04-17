-- Total de pedidos em cada mês de cada ano

WITH all_pedidos as (
    SELECT 
        p.PDD_ID,
        p.PDD_DATA
    FROM PEDIDOS p

    UNION ALL

    SELECT 
        hp.HPDD_ID AS PDD_ID,
        hp.HPDD_DATA AS PDD_DATA
    FROM HPEDIDOS hp
)

SELECT 
    TO_CHAR(TO_DATE(EXTRACT(MONTH FROM ap.PDD_DATA), 'MM'), 'MONTH') AS "Mês",
    EXTRACT(YEAR FROM ap.PDD_DATA) AS "Ano",
    COUNT(ap.PDD_ID) AS QTD
FROM all_pedidos ap
GROUP BY EXTRACT(MONTH FROM ap.PDD_DATA), EXTRACT(YEAR FROM ap.PDD_DATA)
ORDER BY EXTRACT(YEAR FROM ap.PDD_DATA)