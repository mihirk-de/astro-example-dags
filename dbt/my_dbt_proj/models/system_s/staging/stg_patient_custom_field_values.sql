WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientcustomfieldvalues') }}
)

SELECT
    patientid             AS patient_id,
    fieldid               AS field_id,
    fieldvalue            AS field_value,
    gp_practice_id        AS gp_practice_id
FROM source
