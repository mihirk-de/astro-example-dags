

with pi as (
    select * from {{ ref('stg_prescription_issue') }}
),
p as (
    select prescription_id, gp_practice_id, icd_indication
    from {{ ref('stg_prescriptions') }}
)

select
    pi.prescription_id,
    pi.drug_id,
    pi.issue_date,
    pi.issue_count,
    pi.print_count,
    pi.duration,
    pi.quantity,
    pi.user_id,
    pi.strength,
    pi.form,
    pi.trade_name,
    pi.main_ingredient,
    pi.cost,
    pi.pack_size,
    pi.status,
    pi.date_created,
    pi.date_modified,
    pi.last_updated_by,
    pi.printed_date,
    pi.is_dispensed,
    pi.dispensed_code,
    p.icd_indication as icd10_code,
    pi.gp_practice_id
from pi
inner join p
    on pi.prescription_id = p.prescription_id
    and {{ match_clinic_value('pi', 'p') }}
