-- models/system_s/immunisation/refined/ref_patientimmschedule.sql

SELECT
    * ,
    '{ run_started_at }' AS load_ts_utc
FROM {{ ref('stg_patient_imm_schedule') }}
