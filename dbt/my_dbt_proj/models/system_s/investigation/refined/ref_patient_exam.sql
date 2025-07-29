-- models/system_s/investigation/refined/ref_patient_exam.sql

SELECT
    pinvest_id           AS patient_exam_id,
    investigation_id     AS exam_id,
    patient_id           AS patient_id,
    user_id              AS user_id,
    consultation_id      AS consultation_id,
    CASE status
        WHEN 2 THEN 'Cancelled'
        WHEN 5 THEN 'Awaiting'
        WHEN 9 THEN 'In Review'
        WHEN 33 THEN 'In Review'
        WHEN 17 THEN 'Complete'
    END                   AS status,
    additional_notes     AS notes,
    investigation_date   AS investigation_date,
    date_created         AS date_created,
    date_modified        AS date_modified,
    is_abnormal          AS abnormal,
    gp_practice_id       AS gp_practice_id,
    '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_patient_investigations') }}
