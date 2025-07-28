WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmReviewOcfIndication') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    cdmreviewid AS cdm_review_id,
    cdmocfindicationid AS cdm_ocf_indication_id,
    valueint AS value_int,
    valuebit AS value_bit,
    valuedate AS value_date,
    valuestring AS value_string,
    gp_practice_id AS gp_practice_id
FROM source
