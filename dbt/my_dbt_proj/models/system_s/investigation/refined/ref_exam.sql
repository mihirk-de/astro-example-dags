-- models/system_s/investigation/refined/ref_exam.sql

SELECT
    investigation_id   AS exam_id,
    name               AS name,
    gp_practice_id     AS gp_practice_id,
    '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_investigations') }}
