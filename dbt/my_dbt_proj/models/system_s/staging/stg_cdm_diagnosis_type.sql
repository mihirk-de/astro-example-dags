WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmDiagnosisType') }}
)

SELECT
    id AS id,
    icdcode AS icd_code,
    description AS description,
    active AS active,
    icpccode AS icpc_code,
    snomedcode AS snomed_code,
    selfcarereportfile AS self_care_report_file,
    gp_practice_id AS gp_practice_id
FROM source
