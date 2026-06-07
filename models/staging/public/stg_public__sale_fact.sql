with 

source as (

    select * from {{ source('public', 'sale_fact') }}

),

renamed as (

    select
        store as store_id,
        date,
        temperature,
        fuel_price,
        cpi,
        unemployment,
        isholiday as is_holiday

    from source

)

select * from renamed