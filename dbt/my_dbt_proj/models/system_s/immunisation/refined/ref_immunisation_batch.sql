-- models/system_s/immunisation/refined/ref_immunisation_batch.sql

SELECT
  *,
  '{ run_started_at }' AS load_ts_utc
FROM {{ ref('int_immunisation_batch') }}
