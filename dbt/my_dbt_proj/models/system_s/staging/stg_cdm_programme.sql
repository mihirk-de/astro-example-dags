WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmProgramme') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    title AS title,
    description AS description,
    gp_practice_id AS gp_practice_id
FROM source
