WITH source AS (
  SELECT * FROM {{ source('system_s', 'appointmenttypes') }}
  WHERE {{ filter_by_clinic() }}
)

SELECT
  typeid AS consultation_type_id,
  appname AS consultation_type,
  gp_practice_id
FROM source
