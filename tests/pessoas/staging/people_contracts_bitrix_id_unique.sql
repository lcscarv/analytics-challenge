{{ config(
    tags=["source_test", "gp"]
) }}

/* Test to assure the unicity of employee contracts. */
select
    rn
from (
    select 
        row_number() over(partition by "ID Bitrix", "Data de início") as rn
    from {{ source('raw_gsheets', 'raw_contratos_pessoas') }}
    where "ID Bitrix" is not null
        and "raw_contratos_pessoas"."Situação" != 'A confirmar'
) rn_table
where rn > 1
