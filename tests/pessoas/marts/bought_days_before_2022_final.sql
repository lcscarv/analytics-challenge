{{
    config(
        tags=["gp"]
        , severity = 'warn'
    )
}}

with test as (
    select sum(qty_bought_days) as total_bought_days
    from {{ ref('dim_contributors') }}
    where contract_end_date < '2022-01-01'
)

select *
from test
where total_bought_days != 767