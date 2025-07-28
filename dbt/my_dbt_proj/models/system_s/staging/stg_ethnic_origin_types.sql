-- models/system_s/staging/stg_ethnicorigintypes.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'ethnicorigintypes') }}
)

SELECT
    typeid AS type_id,
    name AS name,
    gp_practice_id AS gp_practice_id
FROM source
