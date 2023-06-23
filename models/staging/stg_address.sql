WITH address AS (
    SELECT
    addressid as address_id
     , addressline1 as first_address_line
     , addressline2 as second_address_line
     , city
     , postalcode as postal_code
     , stateprovinceid as state_province_id
    
    FROM {{source('raw_sheets','address')}}
    )

SELECT * FROM address