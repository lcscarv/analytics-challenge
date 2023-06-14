with sales_reason AS (
    SELECT
    salesreasonid as sales_reason_id
     , reasontype as reason_type
     , name as reason_name
    FROM {{source('raw_sheets','salesreason')}}
)

SELECT * FROM sales_reason