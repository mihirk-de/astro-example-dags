WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewPP') }}
    
)

SELECT
    cdmreviewid AS cdm_review_id,
    outcomeresult AS outcome_result,
    gp_practice_id AS gp_practice_id
FROM source
