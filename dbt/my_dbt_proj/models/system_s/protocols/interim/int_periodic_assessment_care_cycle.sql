WITH
  pac AS (
    SELECT * FROM {{ ref('stg_periodic_assessment_care_cycle') }}
  ),
  cocv AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_visit') }}
  ),
  cocst AS (
    SELECT * FROM {{ ref('stg_cycle_of_care_subtype') }}
  )


SELECT
  pac.id                           AS id,
  cocv.cycle_of_care_id            AS cycle_of_care_id,
  cocv.consultation_id             AS consultation_id,
  cocv.visit_date                  AS visit_date,
  cocv.user_id                     AS user_id,
  cocv.status                      AS status,
  cocv.date_created                AS date_created,
  cocv.date_modified               AS date_modified,
  cocv.last_updated_by             AS last_updated_by,
  pac.weight                       AS weight,
  pac.height                       AS height,
  pac.referral_action              AS referral_action,
  pac.referral_option              AS referral_option,
  pac.immunisation_offered         AS immunisation_offered,
  pac.household_smoking            AS household_smoking,
  pac.brief_intervention           AS brief_intervention,
  pac.gp_practice_id               AS gp_practice_id
FROM pac
LEFT JOIN cocv
  ON pac.cycle_of_care_visit_id = cocv.id
  AND pac.gp_practice_id = cocv.gp_practice_id and {{ match_clinic_value('pac', 'cocv') }}
LEFT JOIN cocst
  ON cocv.cycle_of_care_subtype_id = cocst.id
  AND cocv.gp_practice_id = cocst.gp_practice_id and {{ match_clinic_value('cocv', 'cocst') }}