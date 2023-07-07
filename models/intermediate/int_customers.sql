WITH
    customer AS (
    SELECT *
    FROM {{ref('stg_customers')}}
)
    
    , person AS (
        SELECT 
        business_entity_id as person_id
         , person_first_name || ' ' ||COALESCE(person_middle_name,'') || ' ' || person_last_name || COALESCE(person_suffix,'') as customer_name
        FROM {{ref('stg_person')}}   
)

    , customer_address AS (
        SELECT 
        address_id
         , state_province_id
         , city as customer_city
         , first_address_line as customer_address
        
        FROM {{ref('stg_address')}}
)

    , customer_state AS (
        SELECT 
        state_province_id
         , territory_id
         , state_name
         , country_region_code

        FROM {{ref('stg_stateprovince')}}
    )

    , customer_country AS (
        SELECT
        country_region_code
         , country_name
        
        FROM {{ref('stg_country_region')}}

    )
    
    , credit_card AS (
        SELECT
        credit_card_id
         , person_id
         , card_type
        
        FROM {{ref('stg_creditcard')}}

    )

    , sales_header AS (
        SELECT
        sales_order_id
         , customer_id
         , credit_card_id
         , territory_id
         , address_id
        FROM {{ref('stg_sales_order_hdr')}}

    )

    , join_all AS (
        SELECT DISTINCT
        customer.customer_id
         , customer.person_id
         , customer.territory_id
         , person.customer_name
         , sales_header.address_id
         , credit_card.credit_card_id
         , CASE 
            WHEN credit_card.card_type IS NULL
                THEN 'Not Informed'
            ELSE credit_card.card_type
        END AS card_type
         , customer_address.state_province_id
         , customer_address.customer_city
         , customer_address.customer_address
         , customer_state.country_region_code
         , customer_state.state_name as customer_state
         , customer_country.country_name as customer_country
    
        FROM customer

        INNER JOIN person
            ON person.person_id = customer.person_id        
        LEFT JOIN sales_header
            ON sales_header.customer_id = customer.customer_id
        LEFT JOIN customer_address 
            ON  sales_header.address_id = customer_address.address_id
        LEFT JOIN credit_card
            ON customer.person_id = credit_card.person_id 
        LEFT JOIN customer_state
            ON  customer_address.state_province_id = customer_state.state_province_id 
        LEFT JOIN customer_country
            ON customer_country.country_region_code = customer_state.country_region_code
    )
        
SELECT *
FROM join_all
