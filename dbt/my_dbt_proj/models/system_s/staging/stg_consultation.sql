WITH source AS (
  SELECT * FROM {{ source('system_s', 'consultation') }}
)

SELECT
  consultationid AS consultation_id,
  patientid AS patient_id,
  consultationtype AS consultation_type_id,
  userid AS user_id,
  consultationdate AS consultation_date,
  site AS site_id,
  status,
  datecreated AS date_created,
  datemodified AS date_modified,
  lastupdatedby AS last_updated_by,
  gp_practice_id
FROM source