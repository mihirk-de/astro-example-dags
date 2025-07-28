WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'AsthmaCareCycle') }}
)

SELECT
    id AS id,
    cycleofcarevisitid AS cycle_of_care_visit_id,
    reviewtreatment AS review_treatment,
    reviewcompliance AS review_compliance,
    reviewinhaler AS review_inhaler,
    patienteducation AS patient_education,
    selfmanagementplan AS self_management_plan,
    printedplan AS printed_plan,
    immunisationoffered AS immunisation_offered,
    householdsmoking AS household_smoking,
    briefintervention AS brief_intervention,
    gp_practice_id AS gp_practice_id
FROM source
