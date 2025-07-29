WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CycleOfCareType') }}
    
)

SELECT
    id                         AS id,
    title                      AS title,
    active                     AS active,
    gp_practice_id             AS gp_practice_id
FROM source
