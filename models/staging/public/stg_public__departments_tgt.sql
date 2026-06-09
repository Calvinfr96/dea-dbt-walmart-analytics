with 

source as (

    select * from {{ source('public', 'departments_tgt') }}

),

renamed as (

    select
        store as store_id,
        dept as dept_id,
        date,
        weekly_sales,
        isholiday as is_holiday,
        insert_dts,
        update_dts

    from source

)

select * from renamed