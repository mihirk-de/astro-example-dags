WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmDiagnosisTypeAccessRule') }}
)

SELECT
    id AS id,
    diagnosistypeid AS diagnosis_type_id,
    minageyear AS min_age_year,
    fromdate AS from_date,
    todate AS to_date,
    supportpublic AS support_public,
    supportprivate AS support_private,
    requiresppoutcome AS requires_pp_outcome,
    gp_practice_id AS gp_practice_id
FROM source
