WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmDiagnosisFieldRequirement') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    cdmdiagnosistypeid AS cdm_diagnosis_type_id,
    cdmfieldtypeid AS cdm_field_type_id,
    cdmreviewtypeid AS cdm_review_type_id,
    ismandatory AS is_mandatory,
    istelehealthmandatory AS is_telehealth_mandatory,
    gp_practice_id AS gp_practice_id
FROM source
