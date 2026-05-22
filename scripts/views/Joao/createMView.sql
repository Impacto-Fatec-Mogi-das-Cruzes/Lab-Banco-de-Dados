CREATE MATERIALIZED VIEW DW_USER.FORNECEDORES_VIEW
BUILD IMMEDIATE
REFRESH FORCE
ON DEMAND
AS

WITH fornecedor_vendas AS (
    SELECT
        f.FOC_ID,
        f.FOC_NOME,
        pr.PDT_ID,
        pr.PDT_NOME,
        SUM(pp.PPD_QUANTIDADE) AS TOTAL_VENDIDO
    FROM FORNECEDORES f
        JOIN PEDIDOS pd
            ON f.FOC_ID = pd.PDD_FOC_ID
        JOIN PEDIDOS_PRODUTOS pp
            ON pd.PDD_ID = pp.PPD_PDD_ID
        JOIN PRODUTOS pr
            ON pp.PPD_PDT_ID = pr.PDT_ID
    GROUP BY
        f.FOC_ID,
        f.FOC_NOME,
        pr.PDT_ID,
        pr.PDT_NOME
),

ranking_produtos AS (
    SELECT
        fv.*,
        ROW_NUMBER() OVER (
            PARTITION BY fv.FOC_ID
            ORDER BY fv.TOTAL_VENDIDO DESC
        ) AS RN
    FROM fornecedor_vendas fv
)

SELECT
    rp.FOC_ID,
    rp.FOC_NOME AS NOME_FORNECEDOR,
    rp.PDT_ID,
    rp.PDT_NOME AS PRODUTO_MAIS_VENDIDO,
    rp.TOTAL_VENDIDO
FROM ranking_produtos rp
WHERE RN = 1
ORDER BY rp.TOTAL_VENDIDO desc;