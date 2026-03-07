-- Contagem de Pedidos por Fornecedor
SELECT 
    f.FOC_NOME AS "Nome do Fornecedor",
    COUNT(p.PDD_ID) AS "Contagem de Pedidos"
FROM FORNECEDORES f 
JOIN PEDIDOS p ON f.FOC_ID = p.PDD_FOC_ID
GROUP BY f.FOC_NOME;

/

-- Porcentagem de Qualidade do Produto
SELECT 
    p.PDT_NOME AS "Nome do Produto",
    ROUND(SUM(CASE WHEN q.QAL_NOME = 'Ruim' THEN 1 END) * 100/COUNT(p.PDT_ID),2) || '%' AS "Qualidade Ruim",
    ROUND(SUM(CASE WHEN q.QAL_NOME = 'Regular' THEN 1 END) * 100/COUNT(p.PDT_ID),2) || '%' AS"Qualidade Regular",
    ROUND(SUM(CASE WHEN q.QAL_NOME = 'Bom' THEN 1 END) * 100 /COUNT(p.PDT_ID),2) || '%' AS "Qualidade Bom"
FROM PRODUTOS p 
JOIN PEDIDOS_PRODUTOS pp ON p.PDT_ID = pp.PPD_PDT_ID
JOIN PEDIDOS p2 ON pp.PPD_PDD_ID = p2.PDD_ID
JOIN QUALIDADES q ON p2.PDD_QAL_ID = q.QAL_ID
GROUP BY p.PDT_NOME;