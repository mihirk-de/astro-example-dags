-- models/system_s/staging/stg_immunisationschedule.sql

WITH source AS (
    SELECT
        scheduleid AS schedule_id,
        name AS name,
        status AS status,
        ischildhood AS is_childhood,
        ischildhooddefault AS is_childhood_default,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationschedule') }}
)

SELECT
    schedule_id,
    name,
    status,
    is_childhood,
    is_childhood_default,
    gp_practice_id
FROM source
