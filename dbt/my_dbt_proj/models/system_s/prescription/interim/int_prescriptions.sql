with src as (
    select * from {{ ref('stg_prescriptions') }}
)

select
    prescription_id,
    consultation_id,
    prescription_date,
    case prescription_type
        when 1 then 'Acute'
        when 2 then 'Repeat'
        else null
    end as prescription_type,
    case script_type
        when 1 then 'Private'
        when 2 then 'GMS'
        else null
    end as script_type,
    issue_allowed,
    current_issue,
    total_issued,
    user_id,
    status,
    date_created,
    date_modified,
    last_updated_by,
    cancelled_note,
    patient_id,
    generic_only,
    private_note,
    cancelled_reason,
    icd_indication,
    initiated_in,
    cancelled_reason_type,
    long_term,
    prn,
    gp_practice_id
from src
