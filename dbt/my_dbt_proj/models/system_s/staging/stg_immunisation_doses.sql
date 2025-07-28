-- models/system_s/staging/stg_immunisationdoses.sql

WITH source AS (
    SELECT
        doseid AS dose_id,
        name AS name,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationdoses') }}
)

SELECT
    dose_id,
    name,
    gp_practice_id
FROM source
