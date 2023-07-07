WITH sales_order_detail AS (
    SELECT
    salesorderdetailid as sales_order_detail_id
     , salesorderid as sales_order_id
     , productid as product_id
     , orderqty as order_qty
     , unitprice as unit_price
     , unitpricediscount as unit_price_discount
     , (unit_price*order_qty) as gross_revenue
     , ((1 - unit_price_discount)*unit_price*order_qty) as net_income
    
    FROM {{source('raw_sheets','salesorderdetail')}}
    )

SELECT * FROM sales_order_detail