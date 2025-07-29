-- models/system_s/immunisation/refined/ref_courseshots.sql

SELECT
    * ,
    '{ run_started_at }' AS load_ts_utc
FROM {{ ref('stg_course_shots') }}
