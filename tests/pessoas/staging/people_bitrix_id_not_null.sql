{{ config(
    severity='warn'
    , tags=["source_test", "gp"]
) }}

/* Contributors without bitrix ID are going to be without information from this model.
Valid for employee that contract already became active (start_date <= current_date) */

with pessoas as (
    select
        "Nome Contato" as "Funcionário"
        , "ID Bitrix"
        , status as "Situação"
    from {{ source('raw_gsheets', 'raw_pessoas') }}
    where status != 'Inativo'
)

, contratos_pessoas as (
    select
        contratado as "Funcionário"
        , "ID Bitrix"
        , max(to_date("Data de início", 'DD/MM/YYYY')) as "Data de início"
    from {{ source('raw_gsheets', 'raw_contratos_pessoas') }}
    where "Situação" != 'A confirmar'
    group by contratado, "ID Bitrix"
)

, joining as (
    select
        pessoas."Funcionário"
        , pessoas."ID Bitrix"
        , pessoas."Situação"
        , contratos_pessoas."Data de início"
    from pessoas
    left join contratos_pessoas on
            pessoas."Funcionário" = contratos_pessoas."Funcionário"
    where pessoas."ID Bitrix" is null
        and contratos_pessoas."Data de início" is not null
        and contratos_pessoas."Data de início" <= current_date
)

select *
from joining
