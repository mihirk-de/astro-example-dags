WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewDiagnosis') }}
    
)

SELECT
    id                      AS id,
    cdmreviewid             AS cdm_review_id,
    cdmdiagnosistypeid      AS cdm_diagnosis_type_id,
    cdmreviewtypeid         AS cdm_review_type_id,
    diagnosisyear           AS diagnosis_year,
    attendinghospital       AS attending_hospital,
    gp_practice_id          AS gp_practice_id
FROM source
