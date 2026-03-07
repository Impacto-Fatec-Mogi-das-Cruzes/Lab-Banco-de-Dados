-- Pedidos com Qualidade "Bom" e custo total acima de R$130,00
SELECT 
    p.PDD_DATA AS "Data do Pedido",
    'R$' || p.PDD_VALOR_TOTAL AS "Valor Total"
FROM PEDIDOS p
JOIN QUALIDADES q ON p.PDD_QAL_ID = q.QAL_ID
WHERE
    q.QAL_NOME = 'Bom' AND p.PDD_VALOR_TOTAL > 130;

/

-- Quantidade de Fornecedores que Devem e que não Devem e em Dia
SELECT
    COALESCE(SUM(CASE WHEN f.FOC_DIFERENCA > 0 THEN 1 END), 0) AS "A Receber", 
    COALESCE(SUM(CASE WHEN f.FOC_DIFERENCA = 0 THEN 1 END), 0) AS "Em Dia",
    COALESCE(SUM(CASE WHEN f.FOC_DIFERENCA < 0 THEN 1 END), 0) AS "A Pagar"
FROM FORNECEDORES f;