with combined_notes as (

    select * from {{ ref('int_consultation_notes_select') }}
    union all

    select * from {{ ref('int_icd_consultation_notes') }}
    union all

    select * from {{ ref('int_icpc_consultation_notes') }}

)

select *, '{{ run_started_at }}' as LOAD_TS_UTC
from combined_notes