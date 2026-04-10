-- Quantidade total de Alfaces Lisas, Crespas e Americanas compradas no ano de 2025

select
sum(case when p.PDT_NOME = 'Alface Lisa' then hpp.HPPD_QUANTIDADE end) as "Alface Lisa",
sum(case when p.PDT_NOME = 'Alface Americana' then hpp.HPPD_QUANTIDADE end) as "Alface Americana",
sum(case when p.PDT_NOME = 'Alface Crespa' then hpp.HPPD_QUANTIDADE end) as "Alface Crespa"
from HPEDIDOS_PRODUTOS hpp
join PRODUTOS p on hpp.HPPD_PDT_ID = p.PDT_ID
join HPEDIDOS hp on hpp.HPPD_PDD_ID = hp.HPDD_ID
where extract(year from hp.HPDD_DATA) = 2025