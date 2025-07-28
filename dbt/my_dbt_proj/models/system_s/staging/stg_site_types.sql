WITH source AS (
  SELECT * FROM {{ source('system_s', 'sitetypes') }}
  WHERE {{ filter_by_clinic() }}
  -- WHERE gp_practice_id = '{{ var("gp_practice_id") }}'
)

SELECT
  siteid AS site_id,
  name AS site,
  gp_practice_id
FROM source
