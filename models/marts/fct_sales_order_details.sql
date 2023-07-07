WITH 
    sales_order_detail AS (
        SELECT
        sales_order_detail_id
         , sales_order_id
         , product_id
         , order_qty
         , unit_price
         , unit_price_discount       
         , (unit_price*order_qty) as gross_revenue
         , ((1 - unit_price_discount)*unit_price*order_qty) as net_income
         
        FROM {{ref('stg_sales_order_dtl')}}
        )

SELECT * 
FROM sales_order_detail