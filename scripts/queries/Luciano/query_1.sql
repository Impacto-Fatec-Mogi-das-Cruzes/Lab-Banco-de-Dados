-- Total de Produtos Comprados
SELECT
    p.PDT_NOME AS "Produto",
    SUM(pp.PPD_QUANTIDADE) AS "Quantidade"
FROM PEDIDOS_PRODUTOS pp
JOIN PRODUTOS p ON pp.PPD_PDT_ID = p.PDT_ID
GROUP BY pp.PPD_PDT_ID, p.PDT_NOME