WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CYCLEOFCARESUBTYPE') }}
)

SELECT
    id AS id,
    parentid AS parent_id,
    title AS title,
    active AS active,
    supportsclaim AS supports_claim,
    gp_practice_id AS gp_practice_id
FROM source
