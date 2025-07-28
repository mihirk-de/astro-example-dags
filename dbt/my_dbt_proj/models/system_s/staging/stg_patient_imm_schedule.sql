-- models/system_s/staging/stg_patientimmschedule.sql

WITH source AS (
    SELECT
        pisid AS pis_id,
        patientid AS patient_id,
        scheduleid AS schedule_id,
        date AS date,
        consultationid AS consultation_id,
        status AS status,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'patientimmschedule') }}
)

SELECT
    pis_id,
    patient_id,
    schedule_id,
    date,
    consultation_id,
    status,
    gp_practice_id
FROM source
