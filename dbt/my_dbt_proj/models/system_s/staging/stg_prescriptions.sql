with source as (
    select * from {{ source('system_s', 'prescriptions') }}
    WHERE {{ filter_by_clinic() }}
)

select
    prescriptionid as prescription_id,
    consultationid as consultation_id,
    prescriptiondate as prescription_date,
    prescriptiontype as prescription_type,
    scripttype as script_type,
    issuesallowed as issue_allowed,
    currentissue as current_issue,
    totalissued as total_issued,
    userid as user_id,
    status,
    datecreated as date_created,
    datemodified as date_modified,
    lastupdatedby as last_updated_by,
    cancellednote as cancelled_note,
    patientid as patient_id,
    genericonly as generic_only,
    privatenote as private_note,
    cancelledreason as cancelled_reason,
    icdindication as icd_indication,
    initiatedin as initiated_in,
    cancelledreasontype as cancelled_reason_type,
    longterm as long_term,
    prn,
    gp_practice_id
from source
