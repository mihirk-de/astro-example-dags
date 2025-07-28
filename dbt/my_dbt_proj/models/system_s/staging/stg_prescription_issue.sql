with source as (
    select * from {{ source('system_s', 'prescriptionissue') }}
    WHERE {{ filter_by_clinic() }}
)

select
    prescriptionid as prescription_id,
    drugid as drug_id,
    issuedate as issue_date,
    issuecount as issue_count,
    printcount as print_count,
    duration,
    quantity,
    userid as user_id,
    strength,
    form,
    tradename as trade_name,
    mainingredient as main_ingredient,
    cost,
    packsizenum as pack_size,
    status,
    datecreated as date_created,
    datemodified as date_modified,
    lastupdatedby as last_updated_by,
    printeddate as printed_date,
    isdispensed as is_dispensed,
    dispensedcode as dispensed_code,
    gp_practice_id
from source
