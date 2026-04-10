-- Média da quantidade de Alfaces Lisas compradas por mês do ano de 2024

select
sum(hpp.HPPD_QUANTIDADE) as total,
extract(month from hp.HPDD_DATA) as mes
from HPEDIDOS_PRODUTOS hpp
join PRODUTOS p on hpp.HPPD_PDT_ID = p.PDT_ID
join HPEDIDOS hp on hpp.HPPD_PDD_ID = hp.HPDD_ID
where p.PDT_NOME = 'Alface Lisa'
and extract(year from hp.HPDD_DATA) = 2024
group by extract(month from hp.HPDD_DATA)
order by mes