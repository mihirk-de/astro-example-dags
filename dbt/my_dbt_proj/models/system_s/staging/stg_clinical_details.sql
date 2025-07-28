WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'clinicaldetails') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    clinicalid AS clinical_id,
    patientid AS patient_id,
    recordeddate AS recorded_date,
    urine AS urine,
    smokingdate AS smoking_date,
    alcoholdate AS alcohol_date,
    active AS active,
    currentoccupation AS current_occupation,
    substancemisuse AS substance_misuse,
    exsmoker AS ex_smoker,
    weight AS weight,
    smoker AS smoker,
    alcohol AS alcohol,
    height AS height,
    bmi AS bmi,
    obdominal AS obdominal,
    systolic AS systolic,
    diastolic AS diastolic,
    cholesterol AS cholesterol,
    pulse AS pulse,
    peakflow AS peak_flow,
    temp AS temp,
    rhythm AS rhythm,
    smokerstatus AS smoker_status,
    drinkerstatus AS drinker_status,
    ldlcholesterol AS ldl_cholesterol,
    hdlcholesterol AS hdl_cholesterol,
    familycvdhistory AS family_cvd_history,
    lvh AS lvh,
    deleted AS deleted,
    userid AS user_id,
    respiratoryrate AS respiratory_rate,
    headcircumference AS head_circumference,
    ejectionfraction AS ejection_fraction,
    physicalexercise AS physical_exercise,
    gp_practice_id AS gp_practice_id
FROM source
