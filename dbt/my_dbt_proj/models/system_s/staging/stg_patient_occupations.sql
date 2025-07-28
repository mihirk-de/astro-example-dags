-- models/system_s/staging/stg_patientoccupations.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientoccupations') }}
)

SELECT
    occupationid AS occupation_id,
    patientid AS patient_id,
    occupation AS occupation,
    status AS status,
    occupationstartdate AS occupationstart_date,
    occupationenddate AS occupationend_date,
    gp_practice_id AS gp_practice_id
FROM source
