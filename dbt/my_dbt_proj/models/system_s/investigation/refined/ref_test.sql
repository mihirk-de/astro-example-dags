-- models/system_s/investigation/refined/ref_test.sql

SELECT
    investigation_item_id  AS test_id,
    name                   AS name,
    CASE field_type
        WHEN 1 THEN 'Number'
        WHEN 2 THEN 'Text'
        WHEN 3 THEN 'Decimal'
        WHEN 4 THEN 'Yes/No'
        WHEN 5 THEN 'Date'
        WHEN 6 THEN 'Image'
        WHEN 7 THEN 'List'
    END                    AS field_type,
    unit                   AS unit,
    min_val                AS min_val,
    max_val                AS max_val,
    normal_min             AS normal_min,
    normal_max             AS normal_max,
    description            AS description,
    calculated_expression  AS expression,
    date_created           AS date_created,
    date_modified          AS date_modified,
    gp_practice_id         AS gp_practice_id,
    '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_investigation_items') }}
