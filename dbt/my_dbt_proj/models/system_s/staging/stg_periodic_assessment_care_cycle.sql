WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'PeriodicAssessmentCareCycle') }}
)

SELECT
    id AS id,
    cycleofcarevisitid AS cycle_of_care_visit_id,
    weight AS weight,
    height AS height,
    referralaction AS referral_action,
    referraloption AS referral_option,
    immunisationoffered AS immunisation_offered,
    householdsmoking AS household_smoking,
    briefintervention AS brief_intervention,
    gp_practice_id AS gp_practice_id
FROM source
