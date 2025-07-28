-- models/system_s/staging/stg_lab_investigation.sql

WITH source AS (
    SELECT
        LABINVESTIGATIONID AS lab_investigation_id,
        LABCODE AS lab_code,
        LABNAME AS lab_name,
        DATECREATED AS date_created,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'labinvestigation') }}
)

SELECT
    lab_investigation_id,
    lab_code,
    lab_name,
    date_created,
    gp_practice_id
FROM source
