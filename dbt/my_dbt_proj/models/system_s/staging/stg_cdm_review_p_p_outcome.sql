WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewPPOutcome') }}
    
)

SELECT
    id AS id,
    cdmreviewid AS cdm_review_id,
    outcomeresult AS outcome_result,
    cdmdiagnosistype AS cdm_diagnosis_type,
    gp_practice_id AS gp_practice_id
FROM source
