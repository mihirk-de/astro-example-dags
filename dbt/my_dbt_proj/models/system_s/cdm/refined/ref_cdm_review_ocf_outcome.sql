

SELECT
  *,
  '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_cdm_review_ocf_outcome') }}
