WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmPPFieldRequirement') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    cdmfieldtypeid AS cdm_field_type_id,
    cdmreviewtypeid AS cdm_review_type_id,
    ismandatory AS is_mandatory,
    istelehealthmandatory AS is_telehealth_mandatory,
    gp_practice_id AS gp_practice_id
FROM source
