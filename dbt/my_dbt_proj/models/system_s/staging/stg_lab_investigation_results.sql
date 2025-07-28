-- models/system_s/staging/stg_lab_investigation_results.sql

WITH source AS (
    SELECT
        RESULTID AS result_id,
        LABPINVESTID AS lab_pinvest_id,
        LABITEMCODE AS lab_item_code,
        LABITEMNAME AS lab_item_name,
        RESULT AS result,
        RESULTFORMAT AS result_format,
        ADDITIONALNOTES AS additional_notes,
        UNIT AS unit,
        REFERENCERANGE AS reference_range,
        ABNORMALITY AS abnormality,
        RESULTSTATUS AS result_status,
        DATECREATED AS date_created,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'labinvestigationresults') }}
)

SELECT
    result_id,
    lab_pinvest_id,
    lab_item_code,
    lab_item_name,
    result,
    result_format,
    additional_notes,
    unit,
    reference_range,
    abnormality,
    result_status,
    date_created,
    gp_practice_id
FROM source
