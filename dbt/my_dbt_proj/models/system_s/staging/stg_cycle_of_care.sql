WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CycleOfCare') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id                         AS id,
    patientid                  AS patient_id,
    cycleofcaretypeid          AS cycle_of_care_type_id,
    registrationdate           AS registration_date,
    registeredby               AS registered_by,
    ethnicitycode              AS ethnicity_code,
    status                     AS status,
    datecreated                AS date_created,
    datemodified               AS date_modified,
    lastupdatedby              AS last_updated_by,
    gp_practice_id             AS gp_practice_id
FROM source
