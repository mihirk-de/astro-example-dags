{{ 
  config(
    materialized='incremental',
    on_schema_change='fail',
    pre_hook=[
        "{{ delete_practice_pre_hook(var_name='gp_practice_id') }}"
    ]
  ) 
}}

with combined_notes as (

    select * from {{ ref('int_consultation_notes_select') }}
    WHERE {{ filter_by_clinic() }}

    union all

    select * from {{ ref('int_icd_consultation_notes') }}
    WHERE {{ filter_by_clinic() }}

    union all

    select * from {{ ref('int_icpc_consultation_notes') }}
    WHERE {{ filter_by_clinic() }}

)

select *, '{{ run_started_at }}' as LOAD_TS_UTC
from combined_notes
WHERE {{ filter_by_clinic() }}