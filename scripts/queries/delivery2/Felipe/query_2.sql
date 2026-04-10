-- Venda mensal do produto mais vendido do ano de 2024

WITH anual_sales AS (
    SELECT 
        SUM(hpp.HPPD_QUANTIDADE) AS total,
        p.PDT_NOME AS produto,
        p.PDT_ID AS produto_id
    FROM HPEDIDOS hp
    JOIN HPEDIDOS_PRODUTOS hpp 
        ON hp.HPDD_ID = hpp.HPPD_PDD_ID
    JOIN PRODUTOS p 
        ON hpp.HPPD_PDT_ID = p.PDT_ID
    WHERE EXTRACT(YEAR FROM hp.HPDD_DATA) = 2024
    GROUP BY p.PDT_NOME, p.PDT_ID
    ORDER BY total DESC
    FETCH FIRST 1 ROWS ONLY
)
SELECT
    SUM(hpp.HPPD_QUANTIDADE) AS total,
    ans.produto,
    EXTRACT(MONTH FROM hp.HPDD_DATA) AS mes
FROM anual_sales ans
JOIN HPEDIDOS_PRODUTOS hpp 
    ON ans.produto_id = hpp.HPPD_PDT_ID
JOIN HPEDIDOS hp 
    ON hpp.HPPD_PDD_ID = hp.HPDD_ID
WHERE EXTRACT(YEAR FROM hp.HPDD_DATA) = 2024
GROUP BY 
    ans.produto,
    EXTRACT(MONTH FROM hp.HPDD_DATA)
ORDER BY mes;