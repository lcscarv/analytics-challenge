 WITH products AS (
    SELECT 
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk
     , product_id
     , product_manufacture_time
     , product_sell_price    
     , product_standard_cost
     , product_name
     , product_number   
     , product_house_manufactured
     , product_good_finish
     , product_stock_qty_to_reorder
     , product_min_stock_qty
     , product_color
     , product_class   
     , product_line
     , product_style  
     , product_sell_start_date
     , product_availability

     FROM {{ref('stg_products')}}

 )

SELECT *
FROM products
