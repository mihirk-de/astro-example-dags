WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmOcfIndication') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    title AS title,
    description AS description,
    codetype1 AS code_type_1,
    code1 AS code_1,
    active AS active,
    gp_practice_id AS gp_practice_id
FROM source
