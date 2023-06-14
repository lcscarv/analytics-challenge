WITH sales_order_header_sales_reason AS (
    SELECT
    salesorderid as sales_order_id
     , salesreasonid as sales_reason_id

    FROM {{source('raw_sheets','salesorderheadersalesreason')}}
    )

SELECT * FROM sales_order_header_sales_reason