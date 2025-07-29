

SELECT
  *,
  '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_cdm_diagnosis_type_access_rule') }}
