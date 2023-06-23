WITH sales_reason AS (
    SELECT
    {{ dbt_utils.generate_surrogate_key(['sales_reason_id']) }} as sales_reason_sk
     , sales_reason_id
     , reason_type
     , reason_name
   
    FROM {{ref("stg_salesreason")}}
    
)

SELECT *
FROM sales_reason