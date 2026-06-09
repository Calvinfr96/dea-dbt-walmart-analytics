{% snapshot snapshot_facts_scd2 %}

{{
    config(
      target_database=var('db_name'),
      target_schema=var('schema_name'),
      unique_key='FACTS_COMPOSITE_KEY',
      
      strategy='check',
      check_cols=[
        'temperature',
        'fuel_price',
        'markdown_1',
        'markdown_2',
        'markdown_3',
        'markdown_4',
        'markdown_5',
        'cpi',
        'unemployment',
        'is_holiday',
        'insert_dts',
        'source_file_name',
        'source_file_row_number'
      ]
    )
}}

select
{{ dbt.concat(["store_id", "'-'", "date"]) }} as FACTS_COMPOSITE_KEY,
*
from {{ ref('stg_public__facts_source') }}

{% endsnapshot %}
