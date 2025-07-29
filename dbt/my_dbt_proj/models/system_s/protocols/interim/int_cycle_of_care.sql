WITH
  coc AS (
    SELECT * FROM {{ ref('stg_cycle_of_care') }}
  ),
  coct AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_type') }}
  ),
  coclc AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_list_code') }}
  )

SELECT
    coc.id,
    coc.patient_id AS patient_id,
    coct.title AS cycle_of_care_type,
    coc.registration_date AS registration_date,
    coclc.title AS ethnicity_title,
    coc.registered_by AS registered_by,
    coc.date_created AS date_created,
    coc.date_modified AS date_modified,
    coc.last_updated_by AS last_updated_by,
    coc.Status AS status,
    coc.gp_practice_id AS gp_practice_id
FROM coc
LEFT JOIN RAW_CONSOLIDATED_DEV.SYSTEM_S.CYCLEOFCARETYPE coct
    ON coc.cycle_of_care_type_id = coct.id and {{ match_clinic_value('coc', 'coct') }}
LEFT JOIN RAW_CONSOLIDATED_DEV.SYSTEM_S.CYCLEOFCARELISTCODE coclc
    ON coc.ethnicity_code = coclc.id and {{ match_clinic_value('coc', 'coclc') }}
