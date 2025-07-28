-- models/system_s/staging/stg_investigation_results.sql

WITH source AS (
    SELECT
        PINVESTID AS pinvest_id,
        INVESTIGATIONID AS investigation_id,
        INVESTIGATIONITEMID AS investigation_item_id,
        ADDITIONALNOTES AS additional_notes,
        RESULT AS result,
        DATECREATED AS date_created,
        DATEMODIFIED AS date_modified,
        LASTUPDATEDBY AS last_updated_by,
        LABITEMNAME AS lab_item_name,
        ABNORMALITY AS abnormality,
        HRANGE AS high_range,
        LRANGE AS low_range,
        LISTKEY AS list_key,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'investigationresults') }}
)

SELECT
    pinvest_id,
    investigation_id,
    investigation_item_id,
    additional_notes,
    result,
    date_created,
    date_modified,
    last_updated_by,
    lab_item_name,
    abnormality,
    high_range,
    low_range,
    list_key,
    gp_practice_id
FROM source
