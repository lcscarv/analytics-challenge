WITH credit_card AS (
    SELECT 
         creditcardid AS credit_card_id
         , cardtype as card_type
         , expmonth as card_exp_month
         , expyear as card_exp_year
         
    FROM {{source('raw_sheets','creditcard')}}
    )
    , person_credit_card AS (
        SELECT 
            businessentityid as person_id
             , creditcardid as credit_card_id

        FROM {{source('raw_sheets','personcreditcard')}}
    )

    , join_all AS (
        SELECT 
            credit_card.credit_card_id
             , person_credit_card.person_id
             , credit_card.card_type
             , credit_card.card_exp_month
             , credit_card.card_exp_year
        FROM credit_card
        LEFT JOIN person_credit_card
            ON person_credit_card.credit_card_id = credit_card.credit_card_id
    )

SELECT * FROM join_all