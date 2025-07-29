WITH
  dcc AS (
    SELECT * FROM {{ ref('stg_diabetes_care_cycle') }}
  ),
  cocv AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_visit') }}
  ),
  cocst AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_subtype') }}
  )

SELECT
  dcc.id                              AS id,
  cocv.cycle_of_care_id               AS cycle_of_care_id,
  cocst.title                         AS cycle_of_care_sub_type,
  cocv.consultation_id                AS consultation_id,
  cocv.visit_date                     AS visit_date,
  cocv.user_id                        AS user_id,
  cocv.status                         AS status,
  cocv.date_created                   AS date_created,
  cocv.date_modified                  AS date_modified,
  cocv.last_updated_by                AS last_updated_by,
  dcc.hba1c                           AS hba1c,
  dcc.total_cholesterol               AS total_cholesterol,
  dcc.ldl_cholesterol                 AS ldl_cholesterol,
  dcc.creatinine                      AS creatinine,
  dcc.acr                             AS acr,
  dcc.microalbuminuria                AS microalbuminuria,
  dcc.smoking                         AS smoking,
  dcc.alcohol                         AS alcohol,
  dcc.exercise                        AS exercise,
  dcc.brief_intervention              AS brief_intervention,
  dcc.review_treatment                AS review_treatment,
  dcc.foot_review                     AS foot_review,
  dcc.foot_referral                   AS foot_referral,
  dcc.retinopathy_screening           AS retinopathy_screening,
  dcc.retinopathy_screening_referral  AS retinopathy_screening_referral,
  dcc.weight                          AS weight,
  dcc.height                          AS height,
  dcc.bmi                             AS bmi,
  dcc.weight_brief_intervention       AS weight_brief_intervention,
  dcc.systolic                        AS systolic,
  dcc.diastolic                       AS diastolic,
  dcc.immunisation_offered            AS immunisation_offered,
  dcc.patient_education               AS patient_education,
  dcc.cycle_of_care_continued         AS cycle_of_care_continued,
  dcc.schedule_next_review            AS schedule_next_review,
  dcc.reason_for_stopping             AS reason_for_stopping,
  dcc.gp_practice_id                  AS gp_practice_id
FROM dcc
LEFT JOIN cocv
  ON dcc.cycle_of_care_visit_id = cocv.id
  AND dcc.gp_practice_id = cocv.gp_practice_id and {{ match_clinic_value('dcc', 'cocv') }}
LEFT JOIN cocst
  ON cocv.cycle_of_care_subtype_id = cocst.id
  AND cocv.gp_practice_id = cocst.gp_practice_id and {{ match_clinic_value('cocv', 'cocst') }}
