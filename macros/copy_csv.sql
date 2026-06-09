{% macro copy_csv(table_name) %}
    CREATE TRANSIENT TABLE IF NOT EXISTS {{var ('db_name') }}.{{var ('schema_name')}}.{{ table_name }} (
        Store INT,
        Date DATE,
        Temperature DECIMAL(10, 2),
        Fuel_Price DECIMAL(10, 2),
        MarkDown1 DECIMAL(10, 2),
        MarkDown2 DECIMAL(10, 2),
        MarkDown3 DECIMAL(10, 2),
        MarkDown4 DECIMAL(10, 2),
        MarkDown5 DECIMAL(10, 2),
        CPI DECIMAL(10, 7),
        Unemployment DECIMAL(10, 3),
        IsHoliday BOOLEAN,
        INSERT_DTS TIMESTAMP(6),
        SOURCE_FILE_NAME VARCHAR,
        SOURCE_FILE_ROW_NUMBER NUMBER
    );

    delete from {{ var('db_name') }}.{{ var('schema_name') }}.{{ table_name }};

    COPY INTO {{ var('db_name') }}.{{ var('schema_name') }}.{{ table_name }} 
    FROM 
    (
    SELECT
        $1 AS Store,
        $2 AS Date,
        $3 AS Temperature,
        $4 AS Fuel_Price,
        $5 AS MarkDown1,
        $6 AS MarkDown2,
        $7 AS MarkDown3,
        $8 AS MarkDown4,
        $9 AS MarkDown5,
        $10 AS CPI,
        $11 AS Unemployment,
        $12 AS IsHoliday,
        CURRENT_TIMESTAMP() AS INSERT_DTS,
        metadata$filename AS SOURCE_FILE_NAME,
        metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER
    FROM @{{ var('stage_name') }}
    )

    FILE_FORMAT = {{ var('file_format_csv') }}
    PURGE={{ var('purge_status') }}
    FORCE = TRUE;
{% endmacro %}
