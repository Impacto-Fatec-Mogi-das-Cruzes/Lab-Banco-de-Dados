-- Contagem de Pedidos por Fornecedor
SELECT 
    f.FOC_NOME AS "Nome do Fornecedor",
    COUNT(p.PDD_ID) AS "Contagem de Pedidos"
FROM FORNECEDORES f 
JOIN PEDIDOS p ON f.FOC_ID = p.PDD_FOC_ID
GROUP BY f.FOC_NOME;