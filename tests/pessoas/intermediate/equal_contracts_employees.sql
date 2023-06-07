{{
    config(
        tags=["gp"]
        , severity = 'warn'
    )
}}

/* The objective of this test is to check if the number of contract in the vacation_balance is the same 
as the number of contract in the dim_contributors model, contracts that aren't registred at the source
of vacation_balace won't be able to see their vacation balance. */
with vacation_balance as (
    select *
    from {{ ref("stg_vacation_balance") }}
    where contract_status != 'Pendente'
)

, contributors as (
    select *
    from {{ ref("dim_contributors") }}
)

, joining as (
    select
       vacation_balance.contract_id
       , vacation_balance.employee_full_name
       , contributors.contributor_sk
    from vacation_balance
    left join contributors on
        vacation_balance.employee_full_name = contributors.employee_full_name
        and vacation_balance.contract_start_date 
            between contributors.contract_start_date and contributors.contract_end_date
)

select *
from contributors
where
    contributor_sk not in (select contributor_sk from joining)
    and employee_full_name is not null