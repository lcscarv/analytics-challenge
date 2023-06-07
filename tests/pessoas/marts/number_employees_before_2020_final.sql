/*This test ensures by the old number of contributors that the final table 
contains this correct information and the rows have not been duplicated.
The same test was applied to the raw table (raw_contratos_pessoas)*/
with expected_distinct_people_final as (
    select
        count(distinct employee_full_name) as expected_distinct_people
        , count(*) as expected_number_of_rows
    from {{ ref("dim_contributors") }}
    where contract_start_date < '2020-01-01'
)

select *
from expected_distinct_people_final
where
    expected_distinct_people != 22
    and expected_number_of_rows !=26