WITH source AS (
  SELECT * FROM {{ source('system_s', 'appointmenttypes') }}
)

SELECT
  typeid AS consultation_type_id,
  appname AS consultation_type,
  gp_practice_id
FROM source
