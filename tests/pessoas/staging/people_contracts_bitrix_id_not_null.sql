{{ config(
    severity='warn'
    , tags=["source_test", "gp"]
) }}


select *
from {{ source('raw_gsheets', 'raw_contratos_pessoas') }}
where
    "ID Bitrix" is null
    and "Situação" != 'Pendente'
    