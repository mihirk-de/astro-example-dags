-- models/system_s/immunisation/refined/ref_immunisationschedule.sql

SELECT
    * ,
    '{ run_started_at }' AS load_ts_utc
FROM {{ ref('stg_immunisation_schedule') }}
