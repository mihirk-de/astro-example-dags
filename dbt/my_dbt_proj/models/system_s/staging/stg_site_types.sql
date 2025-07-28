WITH source AS (
  SELECT * FROM {{ source('system_s', 'sitetypes') }}
)

SELECT
  siteid AS site_id,
  name AS site,
  gp_practice_id
FROM source
