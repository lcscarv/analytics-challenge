WITH sales_reason AS (
    SELECT
    sales_reason_id
     , reason_type
     , reason_name 
    
    from {{ref('stg_salesreason')}}
    )

 , sales_reason_header AS (
    SELECT
    sales_order_id
     , sales_reason_id
    
    FROM {{ref('stg_sales_order_hd_reason')}}

 )

 , join_all AS (
    SELECT 
    sales_reason_header.sales_order_id
     , sales_reason.sales_reason_id
     , sales_reason.reason_type
     , sales_reason.reason_name 

    FROM sales_reason_header
    LEFT JOIN sales_reason
        ON sales_reason_header.sales_reason_id = sales_reason.sales_reason_id

 )

SELECT *
FROM join_all