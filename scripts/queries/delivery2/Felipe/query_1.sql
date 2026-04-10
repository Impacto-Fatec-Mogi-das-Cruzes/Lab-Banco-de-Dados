-- Produto mais vendido do ano 2024

select 
sum (hpp.HPPD_QUANTIDADE) as total,
p.PDT_NOME as produto
from HPEDIDOS hp
join HPEDIDOS_PRODUTOS hpp on hp.HPDD_ID = hpp.HPPD_PDD_ID
join PRODUTOS p on hpp.HPPD_PDT_ID = p.PDT_ID
where extract(year from hp.HPDD_DATA) = '2024'
group by p.PDT_NOME
order by total desc 
fetch first 1 rows only
