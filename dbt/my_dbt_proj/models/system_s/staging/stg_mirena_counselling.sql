WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'mirenacounselling') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    mirenaid AS mirena_id,
    patientid AS patient_id,
    consultationid AS consultation_id,
    userid AS user_id,
    parity AS parity,
    ageofkids AS age_of_kids,
    prevlscs AS prev_lscs,
    caesareansections AS caesarean_sections,
    "PERIODS " AS counselling_periods,
    familyplanning AS family_planning,
    historyasthma AS history_asthma,
    patientdiscussmirena AS patient_discuss_mirena,
    patrefbygp AS pat_ref_by_gp,
    "PATREADINFO " AS pat_read_info,
    patsentleaflet AS pat_sent_leaflet,
    datecreated AS date_created,
    "DATEMODIFIED " AS date_modified,
    lastupdatedby AS last_updated_by,
    clamydiatest AS clamydia_test,
    lmp AS lmp,
    lmpcomments AS lmp_comments,
    prevcontraception AS prev_contraception,
    contraceptionnotes AS contraception_notes,
    pastpid AS past_pid,
    pastpidnotes AS past_pid_notes,
    "OBSTETRICALHISTORY " AS obstetrical_history,
    pastmedicalhistory AS past_medical_history,
    currentmeds AS current_meds,
    allergies AS allergies,
    gp_practice_id AS gp_practice_id
FROM source
