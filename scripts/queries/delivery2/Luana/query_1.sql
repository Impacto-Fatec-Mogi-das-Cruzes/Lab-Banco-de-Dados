-- Média da quantidade de Alfaces Lisas compradas por mês do ano de 2024

select
sum(hpp.HPPD_QUANTIDADE) as total,
to_char(to_date(extract(month from hp.HPDD_DATA), 'MM'), 'month') as mes
from HPEDIDOS_PRODUTOS hpp
join PRODUTOS p on hpp.HPPD_PDT_ID = p.PDT_ID
join HPEDIDOS hp on hpp.HPPD_PDD_ID = hp.HPDD_ID
where p.PDT_NOME = 'Alface Lisa'
and extract(year from hp.HPDD_DATA) = 2024
group by extract(month from hp.HPDD_DATA)
order by extract(month from hp.HPDD_DATA)