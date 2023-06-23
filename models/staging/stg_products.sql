with products as (
    SELECT 
         productid as product_id
        , daystomanufacture as product_manufacture_time
        , listprice as product_sell_price
        , standardcost as product_standard_cost
        , name as product_name
        , productnumber as product_number 
        , makeflag as product_house_manufactured
        , finishedgoodsflag as product_good_finish
        , reorderpoint as product_stock_qty_to_reorder
        , safetystocklevel as product_min_stock_qty
        , CASE 
            WHEN color IS NULL 
                THEN 'not Specified'
            ELSE color
        END AS product_color
        , CASE 
            WHEN class = 'L'
                THEN 'Low'
            WHEN class = 'H'
                THEN 'High'
            WHEN class = 'M'
                THEN 'Medium'
            ELSE 'Not Specified'
        END AS product_class

        , CASE 
            WHEN productline = 'R'
                THEN 'Road'
            WHEN productline = 'M'
                THEN 'Mountain'
            WHEN productline = 'T'
                THEN 'Touring'
            WHEN productline = 'S'
                THEN 'Standard'
            ELSE 'Not Specified'
        END AS product_line

        , CASE 
            WHEN style = 'M'
                THEN 'Men'
            WHEN style = 'W'
                THEN 'Women'
            WHEN style = 'U'
                THEN 'Universal'
            ELSE 'Not Specified'
        END AS product_style

        , sellstartdate as product_sell_start_date
        , CASE
            WHEN sellenddate is not null 
                THEN 'Not Available for sale'
            ELSE 
                'Available for sale'
        END AS product_availability
    
    FROM {{source('raw_sheets','product')}}

    )

SELECT * FROM products