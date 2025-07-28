-- models/system_s/staging/stg_lab_patient_investigations.sql

WITH source AS (
    SELECT
        LABPINVESTID AS lab_pinvest_id,
        LABINVESTIGATIONID AS lab_investigation_id,
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
        EXTERNALSTATUS AS external_status,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'labpatientinvestigations') }}
)

SELECT
    lab_pinvest_id,
    lab_investigation_id,
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
    external_status,
    gp_practice_id
FROM source
