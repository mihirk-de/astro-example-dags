-- models/system_s/investigation/refined/ref_patient_test.sql

SELECT
    UUID_STRING()       AS patient_test_id,
    pinvest_id          AS patient_exam_id,
    investigation_item_id AS test_id,
    additional_notes    AS notes,
    result              AS result,
    date_created        AS result_date,
    date_modified       AS date_modified,
    abnormality         AS abnormality,
    low_range           AS low_range,
    high_range          AS high_range,
    gp_practice_id      AS gp_practice_id,
    '{{ run_started_at }}' AS load_ts_utc
FROM {{ ref('stg_investigation_results') }}
