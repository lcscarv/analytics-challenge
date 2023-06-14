WITH customers AS (
    SELECT
        customerid as customer_id
         , personid as person_id
         , territoryid as territory_id
    
    FROM {{source('raw_sheets','customer')}}
    )

SELECT * FROM customers