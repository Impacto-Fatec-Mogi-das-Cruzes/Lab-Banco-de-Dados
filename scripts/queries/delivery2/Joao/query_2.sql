-- Número de Pedidos Vendidos por Fornecedores por Ano

WITH all_pedidos as (
    SELECT
        p.PDD_DATA,
        p.PDD_ID,
        p.PDD_FOC_ID
    FROM PEDIDOS p
    UNION ALL
    SELECT 
        hp.HPDD_DATA as PDD_DATA,
        hp.HPDD_ID as PDD_ID,
        hp.HPDD_FOC_ID as PDD_FOC_ID
    FROM HPEDIDOS hp
)

SELECT
    EXTRACT(YEAR FROM ap.PDD_DATA) as ano,
    f.FOC_NOME as "Nome do Fornecedor",
    COUNT (ap.PDD_ID) as qtd
FROM all_pedidos ap
JOIN FORNECEDORES f ON ap.PDD_FOC_ID = f.FOC_ID
GROUP BY f.FOC_ID, f.FOC_NOME, EXTRACT(YEAR FROM ap.PDD_DATA)
ORDER BY ano