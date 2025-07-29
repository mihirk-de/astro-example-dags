WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewOcf') }}
    
)

SELECT
    cdmreviewid AS cdm_review_id,
    cdmreviewtypeid AS cdm_review_type_id,
    outcomeresult AS outcome_result,
    gp_practice_id AS gp_practice_id
FROM source
