-- models/system_s/staging/stg_patientconsent.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientconsent') }}
)

SELECT
    patientid AS patient_id,
    consentidentifier AS consent_identifier,
    isgiven AS is_given,
    dategiven AS date_given,
    recordedby AS recorded_by,
    datemodified AS date_modified,
    lastupdatedby AS last_updated_by,
    gp_practice_id AS gp_practice_id
FROM source
