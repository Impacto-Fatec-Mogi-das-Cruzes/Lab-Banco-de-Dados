CREATE MATERIALIZED VIEW DW_USER.FORNECEDORES_VIEW
BUILD IMMEDIATE
REFRESH FORCE
ON DEMAND
AS
SELECT
    f.FOC_NOME AS "Nome do Fornecedor",
    COUNT(ap.PDD_ID) AS "Quantidade de Pedidos",
    f.FOC_DIFERENCA AS "Diferença",
    ROUND(f.FOC_DIFERENCA / COUNT(ap.PDD_ID), 2) as "Média da Diferença",
    CASE 
        WHEN f.FOC_DIFERENCA > 0 THEN 'A Pagar'
        WHEN f.FOC_DIFERENCA = 0 THEN 'Em dia'
        when f.FOC_DIFERENCA < 0 THEN 'A Receber'
    END as "Status do Extrato Financeiro",
    ROUND(COUNT(ap.PDD_ID) * 100.0 / SUM(COUNT(ap.PDD_ID)) OVER (), 2) || '%' AS "Percentual de Pedidos",
    COUNT(CASE WHEN q.QAL_NOME = 'Bom' THEN 1 END) AS "Pedidos Bom",
    COUNT(CASE WHEN q.QAL_NOME = 'Regular' THEN 1 END) AS "Pedidos Regular",
    COUNT(CASE WHEN q.QAL_NOME = 'Ruim' THEN 1 END) AS "Pedidos Ruim",
    ROUND(COUNT(CASE WHEN q.QAL_NOME = 'Bom' THEN 1 END) * 100.0 / SUM(COUNT(CASE WHEN q.QAL_NOME = 'Bom' THEN 1 END)) OVER (), 2) AS "Pct Bom do Total Bom",
    ROUND(COUNT(CASE WHEN q.QAL_NOME = 'Regular' THEN 1 END) * 100.0 / SUM(COUNT(CASE WHEN q.QAL_NOME = 'Regular' THEN 1 END)) OVER (), 2) AS "Pct Regular do Total Regular",
    ROUND(COUNT(CASE WHEN q.QAL_NOME = 'Ruim' THEN 1 END) * 100.0 / SUM(COUNT(CASE WHEN q.QAL_NOME = 'Ruim' THEN 1 END)) OVER (), 2) AS "Pct Ruim do Total Ruim"
FROM DEV.FORNECEDORES f
JOIN DW_USER.ALL_PRODUTOS ap ON f.FOC_ID = ap.PDD_FOC_ID
JOIN DEV.QUALIDADES q ON ap.PDD_QAL_ID = q.QAL_ID
GROUP BY f.FOC_ID, f.FOC_NOME, f.FOC_DIFERENCA

SELECT *
FROM DW_USER.FORNECEDORES_VIEW;