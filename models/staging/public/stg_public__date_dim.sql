with 

source as (

    select * from {{ source('public', 'date_dim') }}

),

renamed as (

    select
        store as store_id,
        dept as dept_id,
        date,
        weekly_sales,
        isholiday as is_holiday

    from source

)

select * from renamed