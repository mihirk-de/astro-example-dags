WITH source AS (
    SELECT * 
    FROM {{ source('system_s', 'CdmReviewResult') }}
    
)

SELECT
    id                                AS id,
    cdmreviewid                       AS cdm_review_id,
    cdmfieldtypeid                    AS cdm_field_type_id,
    pinvestid                         AS pinvest_id,
    sourcetype                        AS source_type,
    investigationid                   AS investigation_id,
    investigationitemid               AS investigation_item_id,
    result                            AS result,
    additionalnotes                   AS additional_notes,
    unit                              AS unit,
    referencerange                    AS reference_range,
    abnormality                       AS abnormality,
    gp_practice_id                    AS gp_practice_id
FROM source
