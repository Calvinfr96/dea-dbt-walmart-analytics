with 

source as (

    select * from {{ source('public', 'store_dim') }}

),

renamed as (

    select
        store as store_id,
        type,
        size

    from source

)

select * from renamed