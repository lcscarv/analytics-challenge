/*This test ensures by the old number of contributors that the source table 
contains this correct information and the rows have not been duplicated.
The same test was applied to the final table (dim_contributors)*/
with expected_distinct_people_raw as (
    select
        count(distinct contratado) as expected_distinct_people
        , count(*) as expected_number_of_rows
    from {{ source('raw_gsheets', 'raw_contratos_pessoas') }}
    where "Data de início" like '%2019%'
        or "Data de início" like '%2018%'
        or "Data de início" like '%2017%'
)

select *
from expected_distinct_people_raw
where
    expected_distinct_people != 22
    and expected_number_of_rows !=26