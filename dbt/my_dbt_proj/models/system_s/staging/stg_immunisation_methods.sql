-- models/system_s/staging/stg_immunisationmethods.sql

WITH source AS (
    SELECT
        methodid AS method_id,
        name AS name,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationmethods') }}
)

SELECT
    method_id,
    name,
    gp_practice_id
FROM source
