-- Produtos Menos Vendidos

SELECT 
SUM (hpp.HPPD_QUANTIDADE) AS total,
p.PDT_NOME AS produto
FROM HPEDIDOS hp
JOIN HPEDIDOS_PRODUTOS hpp ON hp.HPDD_ID = hpp.HPPD_PDD_ID
JOIN PRODUTOS p ON hpp.HPPD_PDT_ID = p.PDT_ID
where extract(month from hp.HPDD_DATA) = 12
group by p.PDT_NOME
order by total asc

