-- Soma do Valor Total por Fornecedor
SELECT
f.FOC_NOME AS "Fornecedor", 
'R$' || SUM(p.PDD_VALOR_TOTAL) AS "Valor Total"
FROM PEDIDOS p
JOIN FORNECEDORES f ON p.PDD_FOC_ID = f.FOC_ID
GROUP BY p.PDD_FOC_ID, f.FOC_NOME;