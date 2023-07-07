WITH sales_order_header AS (
    SELECT 
    sales_order_id
     , customer_id   
     , credit_card_id   
     , territory_id  
     , address_id    
     , order_date    
     , order_ship_date
     , due_date      
     , purchase_number
     , revision_number
     , order_status  
     , online_ordered
     , subtotal      
     , tax_amount    
     , total_due     
    FROM {{ref('stg_sales_order_hdr')}}
    
    )

SELECT *
FROM sales_order_header