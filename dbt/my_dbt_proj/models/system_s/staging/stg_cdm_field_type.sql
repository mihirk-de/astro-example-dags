WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmFieldType') }}
)

SELECT
    id AS id,
    description AS description,
    codetype1 AS code_type_1,
    code1 AS code_1,
    codetype2 AS code_type_2,
    code2 AS code_2,
    gp_practice_id AS gp_practice_id
FROM source
