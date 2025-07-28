select
    prescriptionid as prescription_id,
    instructionid as instruction_id,
    orderindex as order_index,
    gp_practice_id
from {{ source('system_s', 'prescriptioninstructions') }}
WHERE {{ filter_by_clinic() }}
