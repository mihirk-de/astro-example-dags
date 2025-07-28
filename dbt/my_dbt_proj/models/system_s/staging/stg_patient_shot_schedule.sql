-- models/system_s/staging/stg_patientshotschedule.sql

WITH source AS (
    SELECT
        pssid AS pss_id,
        pisid AS pis_id,
        shotid AS shot_id,
        courseid AS course_id,
        datedue AS date_due,
        userid AS user_id,
        status AS status,
        ischildhood AS is_childhood,
        courseshotid AS course_shot_id,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'patientshotschedule') }}
)

SELECT
    pss_id,
    pis_id,
    shot_id,
    course_id,
    date_due,
    user_id,
    status,
    is_childhood,
    course_shot_id,
    gp_practice_id
FROM source
