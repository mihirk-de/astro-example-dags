-- models/system_s/staging/stg_investigations.sql

WITH source AS (
    SELECT
        INVESTIGATIONID AS investigation_id,
        NAME AS name,
        STATUS AS status,
        ISSYSTEMLOCKED AS is_system_locked,
        KEYIDENTIFIER AS key_identifier,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'investigations') }}
)

SELECT
    investigation_id,
    name,
    status,
    is_system_locked,
    key_identifier,
    gp_practice_id
FROM source
