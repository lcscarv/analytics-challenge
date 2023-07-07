WITH 
    customer AS (
        SELECT
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
         , customer_id
         , person_id
         , territory_id
         , state_province_id
         , credit_card_id
         , customer_name
         , card_type
         , country_region_code
         , customer_city
         , customer_address
         , customer_state
         , customer_country
        
        FROM {{ref('int_customers')}}
        )

SELECT * 
FROM customer