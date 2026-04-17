with all_pedidos as (
    select 
        p.PDD_DATA,
        pp.PPD_PDT_ID,
        pp.PPD_QUANTIDADE,
        pr.PDT_NOME
    from PEDIDOS p
    join PEDIDOS_PRODUTOS pp on p.PDD_ID = pp.PPD_PDD_ID
    join PRODUTOS pr on pp.PPD_PDT_ID = pr.PDT_ID

    union all

    select 
        hp.HPDD_DATA,
        hpp.HPPD_PDT_ID,
        hpp.HPPD_QUANTIDADE,
        pr.PDT_NOME
    from HPEDIDOS hp
    join HPEDIDOS_PRODUTOS hpp on hp.HPDD_ID = hpp.HPPD_PDD_ID
    join PRODUTOS pr on hpp.HPPD_PDT_ID = pr.PDT_ID
),

agrupado as (
    select 
        extract(year from ap.PDD_DATA) as ano,
        ap.PPD_PDT_ID,
        ap.PDT_NOME,
        sum(ap.PPD_QUANTIDADE) as total
    from all_pedidos ap
    group by extract(year from ap.PDD_DATA), ap.PPD_PDT_ID, ap.PDT_NOME
),

rankeado as (
    select 
        a.*,
        row_number() over (
            partition by a.ano 
            order by a.total desc
        ) as posicao
    from agrupado a
),

top_produto_ano as (
    select *
    from rankeado
    where posicao = 1
)

select 
    t.ano,
    t.PDT_NOME as produto,
    extract(month from ap.PDD_DATA) as mes,
    sum(ap.PPD_QUANTIDADE) as total_mes
from top_produto_ano t
join all_pedidos ap
    on ap.PPD_PDT_ID = t.PPD_PDT_ID
    and extract(year from ap.PDD_DATA) = t.ano
group by 
    t.ano,
    t.PDT_NOME,
    extract(month from ap.PDD_DATA)
order by 
    t.ano,
    mes;