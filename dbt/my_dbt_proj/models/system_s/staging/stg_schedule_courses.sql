-- models/system_s/staging/stg_schedulecourses.sql

WITH source AS (
    SELECT
        scheduleid AS schedule_id,
        courseid AS course_id,
        status AS status,
        orderindex AS order_index,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'schedulecourses') }}
)

SELECT
    schedule_id,
    course_id,
    status,
    order_index,
    gp_practice_id
FROM source
