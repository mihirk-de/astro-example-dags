WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmFieldTypeUnavailability') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    fieldtypeid AS field_type_id,
    userid AS user_id,
    gp_practice_id AS gp_practice_id
FROM source
