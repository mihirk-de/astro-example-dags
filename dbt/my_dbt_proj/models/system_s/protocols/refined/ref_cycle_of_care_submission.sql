

SELECT
  *,
  '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_cycle_of_care_submission') }}
