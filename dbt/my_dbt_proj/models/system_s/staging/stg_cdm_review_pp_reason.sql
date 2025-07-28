WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewPPReason') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    cdmreviewid AS cdm_review_id,
    cdmpreventativereasonid AS cdm_preventative_reason_id,
    diagnosisyear AS diagnosis_year,
    cdmreviewtypeid AS cdm_review_type_id,
    gp_practice_id AS gp_practice_id
FROM source
