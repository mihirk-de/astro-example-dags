-- models/system_s/immunisation/refined/ref_immunisation_shots.sql

SELECT
  *,
  '{ run_started_at }' AS load_ts_utc
FROM {{ ref('int_immunisation_shots') }}
