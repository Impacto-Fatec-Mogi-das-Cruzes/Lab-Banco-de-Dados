-- Quantidade total de Alfaces Lisas, Crespas e Americanas compradas em cada ano

with all_pedidos as (
    select 
        p.PDD_ID,
        p.PDD_DATA,
        p.PDD_STT_ID,
        p.PDD_FOC_ID,
        p.PDD_VALOR_TOTAL,
        p.PDD_VALOR_PAGO,
        p.PDD_QAL_ID,
        pp.PPD_PDD_ID,
        pp.PPD_PDT_ID,
        pp.PPD_QUANTIDADE,
        pr.*
    from PEDIDOS p
    join PEDIDOS_PRODUTOS pp on p.PDD_ID = pp.PPD_PDD_ID
    join PRODUTOS pr on pp.PPD_PDT_ID = pr.PDT_ID

    union all

    select 
        hp.HPDD_ID as PDD_ID,
        hp.HPDD_DATA as PDD_DATA,
        hp.HPDD_STT_ID as PDD_STT_ID,
        hp.HPDD_FOC_ID as PDD_FOC_ID,
        hp.HPDD_VALOR_TOTAL as PDD_VALOR_TOTAL,
        hp.HPDD_VALOR_PAGO as PDD_VALOR_PAGO,
        hp.HPDD_QAL_ID as PDD_QAL_ID,
        hpp.HPPD_PDD_ID as PPD_PDD_ID,
        hpp.HPPD_PDT_ID as PPD_PDT_ID,
        hpp.HPPD_QUANTIDADE as PPD_QUANTIDADE,
        pr.*
    from HPEDIDOS hp
    join HPEDIDOS_PRODUTOS hpp on hp.HPDD_ID = hpp.HPPD_PDD_ID
    join PRODUTOS pr on hpp.HPPD_PDT_ID = pr.PDT_ID
),

agrupado as (
    select 
        extract(year from ap.PDD_DATA) as ano,
        ap.PDT_NOME as produto,
        sum(ap.PPD_QUANTIDADE) as total,
        ap.PPD_PDT_ID
    from all_pedidos ap
    group by extract(year from ap.PDD_DATA), ap.PDT_NOME, ap.PPD_PDT_ID
)

select
sum(case when ap.PDT_NOME = 'Alface Lisa' then ap.PPD_QUANTIDADE end) as "Alface Lisa",
sum(case when ap.PDT_NOME = 'Alface Americana' then ap.PPD_QUANTIDADE end) as "Alface Americana",
sum(case when ap.PDT_NOME = 'Alface Crespa' then ap.PPD_QUANTIDADE end) as "Alface Crespa",
ag.ano
from agrupado ag
join all_pedidos ap
    on ag.PPD_PDT_ID = ap.PPD_PDT_ID
    and extract(year from ap.PDD_DATA) = ag.ano
group by ag.ano
order by ag.ano
