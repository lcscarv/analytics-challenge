{{ config(
    tags=['data_app']
    , severity='error'
) }}

/* Added a test to check if the same employee has more than one contract with end date null.
If an employee has more than one contract open, this issue is going to duplicate rows in fct_activity model.
For the data app if more than 25% of the employee are affect this test is going to fail. */
with people_contract as (
    select
        "ID Bitrix" as id_bitrix
        ,"contratado" as nome
        ,"Situação"
        ,"senioridade"
        ,"departamento"
        ,"Cargo/Função"
        , to_date("Data de início", 'DD/MM/YYYY') as start_date
        , to_date("Data rescisão ", 'DD/MM/YYYY') as end_date
        ,"Tipo de Contrato"
        ,"Formato de contrato"
    from {{ source('raw_gsheets', 'raw_contratos_pessoas') }}
)

, limiting as (
    select round(0.25 * count(*)) as quarter_employees
    from people_contract
    where "Situação" = 'Ativo'
)

, auxiliary as (
    select 
        id_bitrix
        , nome
        , count(*)
    from people_contract
    where end_date is null
        and "Situação" != 'Pendente'
    group by id_bitrix, nome
    having count(*)>1  
)

, joining as (
    select round(count(*)/2) as total_employees_2_enddates_null
    from people_contract
    inner join auxiliary on
        people_contract.id_bitrix = auxiliary.id_bitrix
    where end_date is null
)

select total_employees_2_enddates_null
from joining
cross join limiting
where total_employees_2_enddates_null > quarter_employees
    