-- Total Comprado de cada produto
SELECT
    p.PDT_NOME AS "Produto",
    COALESCE(SUM(pp.PPD_QUANTIDADE), 0) AS "Quantidade Total"
FROM PEDIDOS_PRODUTOS pp
JOIN PRODUTOS p ON pp.PPD_PDT_ID = p.PDT_ID
GROUP BY pp.PPD_PDT_ID, p.PDT_NOME