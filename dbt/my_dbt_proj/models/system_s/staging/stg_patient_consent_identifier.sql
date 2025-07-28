-- models/system_s/staging/stg_patientconsentidentifier.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientconsentidentifier') }}
)

SELECT
    id AS id,
    title AS title,
    issystemconsent AS issystemconsent,
    identifier AS identifier,
    active AS active,
    gp_practice_id AS gp_practice_id
FROM source
