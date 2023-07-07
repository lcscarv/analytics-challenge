WITH state_province AS (
    SELECT
    stateprovinceid as state_province_id
     , territoryid as territory_id
     , name as state_name
     , stateprovincecode as state_province_code
     , countryregioncode as country_region_code
     , isonlystateprovinceflag as state_prov_code_availability
    FROM {{source('raw_sheets','stateprovince')}}
    )

SELECT * FROM state_province