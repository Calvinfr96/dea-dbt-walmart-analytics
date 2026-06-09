with 

source as (

    select * from {{ source('public', 'stores_tgt') }}

),

renamed as (

    select
        store as store_id,
        type,
        size,
        insert_dts,
        update_dts

    from source

)

select * from renamed