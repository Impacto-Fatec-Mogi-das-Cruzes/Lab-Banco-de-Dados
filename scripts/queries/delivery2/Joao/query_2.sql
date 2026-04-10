-- Forncedores com Mais Pedidos nos Meses de Outubro

SELECT
    f.FOC_NOME AS "Nome do Fornecedor",
    COUNT(hp.HPDD_ID) AS "Quantidade"
FROM HPEDIDOS hp
JOIN FORNECEDORES f 
    ON hp.HPDD_FOC_ID = f.FOC_ID
WHERE EXTRACT(MONTH FROM hp.HPDD_DATA) = 10
GROUP BY f.FOC_NOME
ORDER BY "Quantidade" DESC;