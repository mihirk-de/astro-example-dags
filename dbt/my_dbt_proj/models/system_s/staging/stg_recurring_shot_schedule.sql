-- models/system_s/staging/stg_recurringshotschedule.sql

WITH source AS (
    SELECT
        recurringid AS recurring_id,
        shotid AS shot_id,
        courseid AS course_id,
        scheduleid AS schedule_id,
        pisid AS pis_id,
        patientid AS patient_id,
        userid AS user_id,
        recurringcount AS recurring_count,
        nextdatedue AS next_date_due,
        lastdategiven AS last_date_given,
        active AS active,
        datecreated AS date_created,
        datemodified AS date_modified,
        lastupdatedby AS last_updated_by,
        courseshotid AS course_shot_id,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'recurringshotschedule') }}
)

SELECT
    recurring_id,
    shot_id,
    course_id,
    schedule_id,
    pis_id,
    patient_id,
    user_id,
    recurring_count,
    next_date_due,
    last_date_given,
    active,
    date_created,
    date_modified,
    last_updated_by,
    course_shot_id,
    gp_practice_id
FROM source
