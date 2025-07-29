WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CycleOfCareVisit') }}
    
)

SELECT
    id AS id,
    cycleofcareid AS cycle_of_care_id,
    cycleofcaresubtypeid AS cycle_of_care_subtype_id,
    consultationid AS consultation_id,
    visitdate AS visit_date,
    userid AS user_id,
    status AS status,
    datecreated AS date_created,
    datemodified AS date_modified,
    lastupdatedby AS last_updated_by,
    reimbursementsubmissionid AS reimbursement_submission_id,
    clinicalsubmissionid AS clinical_submission_id,
    gp_practice_id AS gp_practice_id
FROM source
