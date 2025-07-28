-- models/system_s/staging/stg_reactions.sql

WITH source AS (
    SELECT
        reactionid AS reaction_id,
        patientid AS patient_id,
        reactiontype AS reaction_type,
        site AS site,
        userid AS user_id,
        reactiondate AS reaction_date,
        additionalnotes AS additional_notes,
        status AS status,
        datecreated AS date_created,
        datemodified AS date_modified,
        lastupdatedby AS last_updated_by,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'reactions') }}
)

SELECT
    reaction_id,
    patient_id,
    reaction_type,
    site,
    user_id,
    reaction_date,
    additional_notes,
    status,
    date_created,
    date_modified,
    last_updated_by,
    gp_practice_id
FROM source
