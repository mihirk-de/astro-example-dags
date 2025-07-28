WITH source AS (
    SELECT *
    FROM {{ source('system_s','insurancescheme') }}
)

SELECT
    schemeid            AS scheme_id,
    schemename          AS scheme_name,
    gp_practice_id      AS gp_practice_id
FROM source
