-- Comparação entre Pedidos Pagos A mais, A menos e Exatamente de Cada Mês

with all_pedidos as (
   select p.pdd_data,
          p.pdd_valor_total,
          p.PDD_VALOR_PAGO
     from pedidos_produtos ppd
     join pedidos p
   on ppd.ppd_pdd_id = p.pdd_id
   union all
   select hp.hpdd_data as pdd_data,
          hp.HPDD_VALOR_TOTAL as pdd_valor_total,
          hp.HPDD_VALOR_PAGO as pdd_valor_pago
     from hpedidos_produtos hppd
     join hpedidos hp
   on hppd.hppd_pdd_id = hp.hpdd_id
)

SELECT 
    EXTRACT(YEAR FROM ap.pdd_data) as "Ano",
    TO_CHAR(TO_DATE(EXTRACT(MONTH FROM ap.PDD_DATA), 'MM'), 'MONTH') AS MES,
    COALESCE(SUM(CASE WHEN ap.pdd_valor_total - ap.pdd_valor_pago > 0 THEN 1 END), 0) AS "A Menos", 
    COALESCE(SUM(CASE WHEN ap.pdd_valor_total - ap.pdd_valor_pago = 0 THEN 1 END), 0) AS "Exato",
    COALESCE(SUM(CASE WHEN ap.pdd_valor_total - ap.pdd_valor_pago < 0 THEN 1 END), 0) AS "A Mais"
FROM all_pedidos ap
GROUP BY EXTRACT(MONTH FROM ap.pdd_data), EXTRACT(YEAR FROM ap.pdd_data)
ORDER BY EXTRACT(YEAR FROM ap.pdd_data)