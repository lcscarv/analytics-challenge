 WITH products AS (
    SELECT 
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk
     , *

     FROM {{ref('int_products')}}

 )

SELECT *
FROM products
