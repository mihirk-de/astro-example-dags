-- models/system_s/investigation/refined/ref_lab_investigation.sql

SELECT
    *,
    '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_lab_investigation') }}
