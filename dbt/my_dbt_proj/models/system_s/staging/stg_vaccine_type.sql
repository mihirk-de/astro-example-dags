-- models/system_s/staging/stg_vaccinetype.sql

WITH source AS (
    SELECT
        id AS id,
        title AS title,
        codetype AS code_type,
        codedescription AS code_description,
        codevalue AS code_value,
        active AS active,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'vaccinetype') }}
)

SELECT
    id,
    title,
    code_type,
    code_description,
    code_value,
    active,
    gp_practice_id
FROM source
