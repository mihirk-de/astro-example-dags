-- models/system_s/staging/stg_immunisationsite.sql

WITH source AS (
    SELECT
        siteid AS site_id,
        name AS name,
        hl7code AS hl7_code,
        hl7text AS hl7_text,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationsite') }}
)

SELECT
    site_id,
    name,
    hl7_code,
    hl7_text,
    gp_practice_id
FROM source
