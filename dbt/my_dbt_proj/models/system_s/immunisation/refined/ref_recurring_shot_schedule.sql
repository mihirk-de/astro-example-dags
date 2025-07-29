-- models/system_s/immunisation/refined/ref_recurringshotschedule.sql

SELECT
    * ,
    '{ run_started_at }' AS load_ts_utc
FROM {{ ref('stg_recurring_shot_schedule') }}
