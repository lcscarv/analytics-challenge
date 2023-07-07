WITH sales_reason AS (
    SELECT 
    {{ dbt_utils.generate_surrogate_key(['sales_reason_id','sales_order_id']) }} as reason_sk
     , sales_order_id
     , sales_reason_id
     , reason_name
     , reason_type

    FROM {{ref('int_salesreason')}}
)

SELECT *
FROM sales_reason