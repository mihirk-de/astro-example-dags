select
    instructionid as instruction_id,
    description,
    code,
    gp_practice_id
from {{ source('system_s', 'druginstructions') }}
WHERE {{ filter_by_clinic() }}