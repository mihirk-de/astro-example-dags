-- models/system_s/staging/stg_immunisationcourses.sql

WITH source AS (
    SELECT
        courseid AS course_id,
        titlename AS title_name,
        status AS status,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationcourses') }}
)

SELECT
    course_id,
    title_name,
    status,
    gp_practice_id
FROM source
