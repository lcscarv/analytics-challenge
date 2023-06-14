WITH country_region AS (
    SELECT
    contryregioncode as country_region_code
     , name as country_name

    FROM {{source('raw_sheets','countryregion')}}
    )

SELECT * FROM country_region