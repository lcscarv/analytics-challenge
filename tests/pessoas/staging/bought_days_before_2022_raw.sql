{{
    config(
        tags=["gp"]
        , severity = 'warn'
    )
}}

with source as (
    select 
        contrato as contract_id
        , "Observação" as bought_vacations_comment
        , "Dias comprados"::int as qty_bought_days
        , to_date("Data Compra", 'DD/MM/YYYY') as bought_date
    from {{ source("raw_gsheets","ferias_horas_compradas") }}
    
)

, total_bought_days as (
	select sum(qty_bought_days) as qty_bought_days
	from source
	where bought_date < '2022-01-01'
)

select *
from total_bought_days
where qty_bought_days != 757
