with source as (

    select
        mh.consultation_id,
        mh.user_id,
        concat(icpc.description, ' ', mh.additional_notes) as note,
        mh.date_created as note_date,
        mh.status,
        mh.date_created,
        mh.date_modified,
        mh.last_updated_by,
        c.patient_id,
        mh.deleted,
        mh.gp_practice_id
    from {{ ref('stg_medical_history') }} mh
    inner join {{ ref('stg_icpc2') }} icpc
        on mh.icpc_code = icpc.icpc_code and {{ match_clinic_value('mh', 'icpc') }}
    inner join {{ ref('stg_consultation') }} c
        on mh.consultation_id = c.consultation_id and {{ match_clinic_value('mh', 'c') }}
    

)

select * from source
