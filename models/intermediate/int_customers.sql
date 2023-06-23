WITH
    customer AS (
    SELECT *
    FROM {{ref('stg_customers')}}
)
    
    , person AS (
        SELECT 
        business_entity_id as person_id
         , person_first_name || COALESCE(person_middle_name,'') || ' ' || person_last_name || COALESCE(person_suffix,'') as customer_name
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
         , sales_header.credit_card_id
          , credit_card.card_type
         , customer_address.state_province_id
         , customer_address.customer_city
         , customer_address.customer_address
         , customer_state.country_region_code
         , customer_country.country_name as customer_country
    
        FROM customer

        INNER JOIN person
            ON person.person_id = customer.person_id        
        INNER JOIN sales_header
            ON sales_header.customer_id = customer.customer_id
        INNER JOIN customer_address 
            ON customer_address.address_id = sales_header.address_id
        INNER JOIN credit_card
            ON credit_card.credit_card_id = sales_header.credit_card_id
        INNER JOIN customer_state
            ON customer_state.state_province_id = customer_address.state_province_id
        INNER JOIN customer_country
            ON customer_country.country_region_code = customer_state.country_region_code
    )
        
SELECT *
FROM join_all
