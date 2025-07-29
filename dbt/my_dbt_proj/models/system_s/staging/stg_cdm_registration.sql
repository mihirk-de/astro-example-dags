WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmRegistration') }}
    
)

SELECT
    id                  AS id,
    patientid           AS patient_id,
    ethnicityid         AS ethnicity_id,
    registrationdate    AS registration_date,
    userid              AS user_id,
    datecreated         AS date_created,
    datemodified        AS date_modified,
    lastupdatedby       AS last_updated_by,
    cdmprogrammeid      AS cdm_programme_id,
    deregistered        AS deregistered,
    deregistereddate    AS deregistered_date,
    gp_practice_id      AS gp_practice_id
FROM source
