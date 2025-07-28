WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewOcfOutcome') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    cdmreviewid AS cdm_review_id,
    outcomeresult AS outcome_result,
    resultvalueint AS result_value_int,
    resultvaluestring AS result_value_string,
    gp_practice_id AS gp_practice_id
FROM source
