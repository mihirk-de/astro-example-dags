-- models/system_s/staging/stg_maritalstatustypes.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'maritalstatustypes') }}
)

SELECT
    typeid AS type_id,
    name AS name,
    gp_practice_id AS gp_practice_id
FROM source
