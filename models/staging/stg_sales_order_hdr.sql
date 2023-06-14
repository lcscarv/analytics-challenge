WITH sales_order_header AS (
    SELECT
    salesorderid as sales_order_id
     , customerid as customer_id
     , creditcardid as credit_card_id
     , territoryid as territory_id
     , shiptoaddressid as address_id
     , orderdate as order_date
     , shipdate as order_ship_date
     , duedate as due_date
     , purchaseordernumber as purchase_number
     , revisionnumber as revision_number
     , CASE 
        WHEN status = 1
            THEN 'In proccess'
        WHEN status = 2
            THEN 'Approved'
        WHEN status = 3
            THEN 'Backordered'
        WHEN status = 4
            THEN 'Rejected'
        WHEN status = 5
            THEN 'Shipped'
        WHEN status = 6
            THEN 'Cancelled'
    END AS order_status
     , onlineorderflag as online_ordered
     , subtotal
     , taxamt as tax_amount
     , totaldue as total_due
    
    FROM {{source('raw_sheets','salesorderheader')}}
    )   

SELECT * FROM sales_order_header