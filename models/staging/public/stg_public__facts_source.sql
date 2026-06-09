{{ config(
    materialized='table',
    pre_hook="{{ copy_csv('FACTS_SOURCE') }}",
    transient=true
) }}

with
source as (
    select * from {{ source('public', 'facts_source') }}
),

renamed as (
    select
        Store as store_id,
        Date as date,
        Temperature as temperature,
        Fuel_Price as fuel_price,
        MarkDown1 as markdown_1,
        MarkDown2 as markdown_2,
        MarkDown3 as markdown_3,
        MarkDown4 as markdown_4,
        MarkDown5 as markdown_5,
        CPI as cpi,
        Unemployment as unemployment,
        IsHoliday as is_holiday,
        INSERT_DTS as insert_dts,
        SOURCE_FILE_NAME as source_file_name,
        SOURCE_FILE_ROW_NUMBER as source_file_row_number
    from source

)

select * from renamed