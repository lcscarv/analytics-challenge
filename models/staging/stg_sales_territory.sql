WITH sales_territory AS (
    SELECT
    territoryid as territory_id
     , saleslastyear as sales_last_year
     , salesytd as sales_year_to_date
     , group 
     , countryregioncode as country_region_code
     , name as group_name

    FROM {{source('raw_sheets','salesterritory')}}
    )

SELECT * FROM sales_territory