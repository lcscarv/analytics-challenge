/* This test assures that our dim_contributors doesn't have (too many) duplicate rows,
so the join between fct_activity and dim_contributors is not duplicating rows.
For the data app if more than 25% of the employee are affect this test is going to fail. */
with contributors as (
    select *
    from {{ ref("dim_contributors") }}
)

, limiting as (
    select round(0.25 * count(*)) as quarter_employees
    from contributors
    where
        is_active_contract = 'Active'
        and is_last_record = true
)

, duplicate_rows as (
    select *
    from contributors
    join (
        select contributor_sk, count(contributor_sk)
        from contributors
        group by contributor_sk
        having count(contributor_sk) > 1
    ) as dup
        on contributors.contributor_sk = dup.contributor_sk
)

, auxiliary as (
    select count(distinct(bitrix_user_id)) as total_employees_duplicated
    from duplicate_rows
)

select total_employees_duplicated
from auxiliary
cross join limiting
where total_employees_duplicated > quarter_employees