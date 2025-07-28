WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'cycleofcaresubmission') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    submissiondate AS submission_date,
    referralcontrolid AS referral_control_id,
    hl7messagefilename AS hl7_message_filename,
    hl7ack AS hl7_ack,
    acknowledgeddate AS acknowledged_date,
    ackerror AS ack_error,
    status AS status,
    gp_practice_id AS gp_practice_id
FROM source
