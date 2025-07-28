-- models/system_s/staging/stg_patient_investigations.sql

WITH source AS (
    SELECT
        PINVESTID AS pinvest_id,
        INVESTIGATIONID AS investigation_id,
        CONSULTATIONID AS consultation_id,
        USERID AS user_id,
        INVESTIGATIONDATE AS investigation_date,
        STATUS AS status,
        DATECREATED AS date_created,
        DATEMODIFIED AS date_modified,
        LASTUPDATEDBY AS last_updated_by,
        ABNORMAL AS is_abnormal,
        PATIENTID AS patient_id,
        ADDITIONALNOTES AS additional_notes,
        ELECTRONICMESSAGE AS electronic_message,
        EXTERNALSTATUS AS external_status,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'patientinvestigations') }}
)

SELECT
    pinvest_id,
    investigation_id,
    consultation_id,
    user_id,
    investigation_date,
    status,
    date_created,
    date_modified,
    last_updated_by,
    is_abnormal,
    patient_id,
    additional_notes,
    electronic_message,
    external_status,
    gp_practice_id
FROM source
