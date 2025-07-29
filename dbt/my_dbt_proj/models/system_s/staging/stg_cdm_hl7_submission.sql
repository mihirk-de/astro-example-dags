WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmHl7Submission') }}
    
)

SELECT
    id                     AS id,
    cdmreviewid            AS cdm_review_id,
    messagetype            AS message_type,
    submissiondate         AS submission_date,
    controlid              AS control_id,
    hl7ack                 AS hl7_ack,
    acknowledgeddate       AS acknowledged_date,
    ackmessage             AS ack_message,
    status                 AS status,
    originalcontrolid      AS original_control_id,
    hl7                    AS hl7,
    datecreated            AS date_created,
    datemodified           AS date_modified,
    lastupdatedby          AS last_updated_by,
    gp_practice_id         AS gp_practice_id
FROM source
