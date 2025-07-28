WITH source AS (
    SELECT *
    FROM {{ source('system_s','insurance') }}
)

SELECT
    insuranceid         AS insurance_id,
    patientid           AS patient_id,
    insurancescheme     AS insurance_scheme_id,
    insurancenumber     AS insurance_number,
    status              AS insurance_status_code,
    gp_practice_id      AS gp_practice_id
FROM source
