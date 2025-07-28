WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'mmse') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    mmseid AS mmse_id,
    patientid AS patient_id,
    consultationid AS consultation_id,
    dateoftest AS date_of_test,
    examiner AS examiner,
    orietnationyear AS orientation_year,
    orietnationseason AS orientation_season,
    orietnationmonth AS orientation_month,
    orietnationdate AS orientation_date,
    orietnationday AS orientation_day,
    orietnationcountry AS orientation_country,
    orietnationcounty AS orientation_county,
    orietnationtown AS orientation_town,
    orietnationplace AS orientation_place,
    orietnationfloor AS orientation_floor,
    registration AS registration,
    attentioncalculation AS attention_calculation,
    recall AS recall,
    languagetwoobjects AS language_two_objects,
    languagerepeat AS language_repeat,
    languagethreestages AS language_three_stages,
    languagereadobey AS language_read_obey,
    languagewrite AS language_write,
    languagecopydesign AS language_copy_design,
    score AS score,
    gp_practice_id AS gp_practice_id
FROM source
