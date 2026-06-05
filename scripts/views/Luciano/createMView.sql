CREATE MATERIALIZED VIEW DW_USER.PEDIDOS_MVIEW
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT 
    EXTRACT(month FROM ap.PDD_DATA) || '/' || EXTRACT(year FROM ap.PDD_DATA) AS "Mês e ano",
    COUNT(ap.PDD_ID) as "Total de pedidos",
    SUM(ap.PDD_VALOR_TOTAL) AS "Valor total a ser pago no mês",
    SUM(ap.PDD_VALOR_PAGO) AS "Valor total pago no mês",
    SUM(ap.PDD_VALOR_PAGO) - SUM(ap.PDD_VALOR_TOTAL) AS "Diferença entre o pago e a ser pago no mês",
    ROUND(SUM(ap.PDD_VALOR_TOTAL) / EXTRACT(DAY FROM LAST_DAY(ap.PDD_DATA)), 2) AS " Preço médio diário dos pedidos",
    ROUND(SUM(ap.PDD_VALOR_PAGO) / EXTRACT(DAY FROM LAST_DAY(ap.PDD_DATA)), 2) AS " Gasto médio diário dos pedidos",
    CASE
        WHEN SUM(ap.PDD_VALOR_TOTAL) > AVG(SUM(ap.PDD_VALOR_TOTAL)) OVER () THEN 'maior'
        WHEN SUM(ap.PDD_VALOR_TOTAL) < AVG(SUM(ap.PDD_VALOR_TOTAL)) OVER () THEN 'menor'
        WHEN SUM(ap.PDD_VALOR_TOTAL) = AVG(SUM(ap.PDD_VALOR_TOTAL)) OVER () THEN 'igual'
    END AS "Valor total acima, abaixo ou igual a média",
    CASE
        WHEN SUM(ap.PDD_VALOR_PAGO) > AVG(SUM(ap.PDD_VALOR_PAGO)) OVER () THEN 'maior'
        WHEN SUM(ap.PDD_VALOR_PAGO) < AVG(SUM(ap.PDD_VALOR_PAGO)) OVER () THEN 'menor'
        WHEN SUM(ap.PDD_VALOR_PAGO) = AVG(SUM(ap.PDD_VALOR_PAGO)) OVER () THEN 'igual'
    END AS "Valor pago Acima, abaixo ou igual a média"
FROM DW_USER.ALL_PEDIDOS_VIEW ap
GROUP BY EXTRACT(month FROM ap.PDD_DATA), EXTRACT(year FROM ap.PDD_DATA), EXTRACT(DAY FROM LAST_DAY(ap.PDD_DATA))
ORDER BY EXTRACT(year FROM ap.PDD_DATA), EXTRACT(month FROM ap.PDD_DATA);

-- refresh na view
BEGIN
   dbms_mview.refresh('PEDIDOS_MVIEW', method => 'C', atomic_refresh => FALSE);
END;

/

SELECT *
FROM DW_USER.PEDIDOS_MVIEW;

DROP MATERIALIZED VIEW  DW_USER.PEDIDOS_MVIEW;