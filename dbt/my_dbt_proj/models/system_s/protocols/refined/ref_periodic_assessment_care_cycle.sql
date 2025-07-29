

SELECT
  *,
  '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('int_periodic_assessment_care_cycle') }}
