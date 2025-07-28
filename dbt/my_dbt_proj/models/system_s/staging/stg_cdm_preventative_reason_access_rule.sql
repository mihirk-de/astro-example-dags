WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmPreventativeReasonAccessRule') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    preventativereasonid AS preventative_reason_id,
    minageyear AS min_age_year,
    fromdate AS from_date,
    todate AS to_date,
    supportpublic AS support_public,
    supportprivate AS support_private,
    mindiagnosisyear AS min_diagnosis_year,
    requiresocfoutcome AS requires_ocf_outcome,
    gp_practice_id AS gp_practice_id
FROM source
