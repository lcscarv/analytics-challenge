WITH person AS (
    SELECT 
     businessentityid as business_entity_id
     , firstname as person_first_name
     , middlename as person_middle_name
     , lastname as person_last_name
     , CASE 
        WHEN persontype = 'SC'
            THEN 'Store Contact'
        WHEN persontype = 'IN'
            THEN 'Individual Customer'    
        WHEN persontype = 'EM'
            THEN 'Employee (Non-sales)'
        WHEN persontype = 'VC'
            THEN 'Vendor Contact'
        ELSE 'General Contact'

    END AS person_type
     , suffix as person_suffix
     , title as person_title
      
    FROM {{source('raw_sheets','person')}}
    )

SELECT * FROM person