WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'DiabetesCareCycle') }}
    
)

SELECT
    id AS id,
    cycleofcarevisitid AS cycle_of_care_visit_id,
    hba1c AS hba1c,
    totalcholesterol AS total_cholesterol,
    ldlcholesterol AS ldl_cholesterol,
    creatinine AS creatinine,
    acr AS acr,
    microalbuminuria AS microalbuminuria,
    smoking AS smoking,
    alcohol AS alcohol,
    exercise AS exercise,
    briefintervention AS brief_intervention,
    reviewtreatment AS review_treatment,
    footreview AS foot_review,
    footreferral AS foot_referral,
    retinopathyscreening AS retinopathy_screening,
    retinopathyscreeningreferral AS retinopathy_screening_referral,
    weight AS weight,
    height AS height,
    bmi AS bmi,
    weightbriefintervention AS weight_brief_intervention,
    systolic AS systolic,
    diastolic AS diastolic,
    immunisationoffered AS immunisation_offered,
    patienteducation AS patient_education,
    cycleofcarecontinued AS cycle_of_care_continued,
    schedulenextreview AS schedule_next_review,
    reasonforstopping AS reason_for_stopping,
    gp_practice_id AS gp_practice_id
FROM source
