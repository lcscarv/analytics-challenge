WITH credit_card AS (
    SELECT 
         creditcardid AS credit_card_id
         , cardtype as card_type
         , expmonth as card_exp_month
         , expyear as card_exp_year
         
    FROM {{source('raw_sheets','creditcard')}}
    
    
    )

SELECT * FROM credit_card