-- models/system_s/staging/stg_religiontypes.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'religiontypes') }}
)

SELECT
    typeid AS type_id,
    name AS name,
    gp_practice_id AS gp_practice_id
FROM source
