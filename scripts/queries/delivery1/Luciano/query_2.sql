-- Porcentagem de pedidos em que se foi pago a mais, a menos e exatamente o valor
SELECT
    COALESCE(ROUND(SUM(CASE WHEN p.PDD_VALOR_TOTAL - p.PDD_VALOR_PAGO > 0 THEN 1 END)*100 / COUNT(p.PDD_ID), 2), 0) || '%' AS "A Menos", 
    COALESCE(ROUND(SUM(CASE WHEN p.PDD_VALOR_TOTAL - p.PDD_VALOR_PAGO = 0 THEN 1 END)*100 / COUNT(p.PDD_ID), 2), 0) || '%' AS "Exato",
    COALESCE(ROUND(SUM(CASE WHEN p.PDD_VALOR_TOTAL - p.PDD_VALOR_PAGO < 0 THEN 1 END)*100 / COUNT(p.PDD_ID), 2), 0) || '%' AS "A Mais"
FROM PEDIDOS p;