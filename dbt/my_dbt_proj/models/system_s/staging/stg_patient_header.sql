-- models/system_s/staging/stg_patientheader.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientheader') }}
)

SELECT
    patientid AS patient_id,
    firstname AS first_name,
    dob AS dob,
    ppsn AS ppsn,
    bloodgrouptype AS bloodgroup_type,
    hwnum AS hw_num,
    babycarenum AS babycare_num,
    datecreated AS date_created,
    datemodified AS date_modified,
    lastupdatedby AS last_updated_by,
    uniquenum AS unique_num,
    dispensing AS dispensing,
    personalbalance AS personal_balance,
    familybalance AS family_balance,
    allergystatus AS allergy_status,
    ihinumber AS ihi_number,
    ihidatechecked AS ihi_date_checked,
    gp_practice_id AS gp_practice_id
FROM source
