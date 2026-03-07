-- Quantidade de Pedidos realizados por cada mês
SELECT 
EXTRACT(month FROM p.PDD_DATA) AS "Mês",
COUNT(p.PDD_ID) AS "Quantidade de Pedidos"
FROM PEDIDOS p
GROUP BY EXTRACT(month FROM p.PDD_DATA);
     
/

-- Soma do Valor Total por Fornecedor
SELECT
f.FOC_NOME AS "Fornecedor", 
'R$' || SUM(p.PDD_VALOR_TOTAL) AS "Valor Total"
FROM PEDIDOS p
JOIN FORNECEDORES f ON p.PDD_FOC_ID = f.FOC_ID
GROUP BY p.PDD_FOC_ID, f.FOC_NOME;