WITH
  acc AS (
    SELECT * FROM {{ ref('stg_asthma_care_cycle') }}
  ),
  cocv AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_visit') }}
  ),
  cocst AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_subtype') }}
  )

SELECT
  acc.id                               AS id,
  cocv.cycle_of_care_id                AS cycle_of_care_id,
  cocst.title                          AS cycle_of_care_sub_type,
  cocv.consultation_id                 AS consultation_id,
  cocv.visit_date                      AS visit_date,
  cocv.user_id                         AS user_id,
  cocv.status                          AS status,
  cocv.date_created                    AS date_created,
  cocv.date_modified                   AS date_modified,
  cocv.last_updated_by                 AS last_updated_by,
  acc.review_treatment                 AS review_treatment,
  acc.review_compliance                AS review_compliance,
  acc.review_inhaler                   AS review_inhaler,
  acc.patient_education                AS patient_education,
  acc.self_management_plan             AS self_management_plan,
  acc.printed_plan                     AS printed_plan,
  acc.immunisation_offered             AS immunisation_offered,
  acc.household_smoking                AS household_smoking,
  acc.brief_intervention               AS brief_intervention,
  cocv.reimbursement_submission_id     AS reimbursement_submission_id,
  cocv.clinical_submission_id          AS clinical_submission_id,
  acc.gp_practice_id                   AS gp_practice_id
FROM acc
LEFT JOIN cocv
  ON acc.cycle_of_care_visit_id = cocv.id
  AND acc.gp_practice_id = cocv.gp_practice_id and {{ match_clinic_value('acc', 'cocv') }}
LEFT JOIN cocst
  ON cocv.cycle_of_care_subtype_id = cocst.id
  AND cocv.gp_practice_id = cocst.gp_practice_id and {{ match_clinic_value('cocv', 'cocst') }}
