-- models/system_s/staging/stg_courseshots.sql

WITH source AS (
    SELECT
        courseid AS course_id,
        shotid AS shot_id,
        orderid AS order_id,
        status AS status,
        id AS id,
        intervaltype AS interval_type,
        intervalmonths AS interval_months,
        intervaldays AS interval_days,
        shotnumber AS shot_number,
        shotnumberlabeloverride AS shot_number_label_override,
        gp_practice_id AS gp_practice_id
)

SELECT
    course_id,
    shot_id,
    order_id,
    status,
    id,
    interval_type,
    interval_months,
    interval_days,
    shot_number,
    shot_number_label_override,
    gp_practice_id
FROM source
