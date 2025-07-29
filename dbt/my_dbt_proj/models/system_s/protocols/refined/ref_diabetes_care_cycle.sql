

SELECT
  *,
  '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('int_diabetes_care_cycle') }}
