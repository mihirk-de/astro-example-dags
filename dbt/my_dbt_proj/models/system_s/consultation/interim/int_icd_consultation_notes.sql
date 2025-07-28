with source as (

    select
        mh.consultation_id,
        mh.user_id,
        concat(icd.description, ' ', mh.additional_notes) as note,
        mh.date_created as note_date,
        mh.status,
        mh.date_created,
        mh.date_modified,
        mh.last_updated_by,
        c.patient_id,
        mh.deleted,
        mh.gp_practice_id
    from {{ ref('stg_medical_history') }} mh
    inner join {{ ref('stg_icd10') }} icd
        on mh.icd_code = icd.icd_code and {{ match_clinic_value('mh', 'icd') }}
    inner join {{ ref('stg_consultation') }} c
        on mh.consultation_id = c.consultation_id and {{ match_clinic_value('mh', 'c') }}
)

select * from source
