with source as (

    select
        consultation_id,
        user_id,
        note,
        note_date,
        status,
        date_created,
        date_modified,
        last_updated_by,
        patient_id,
        deleted,
        gp_practice_id
    from {{ ref('stg_consultation_notes') }} 
)

select * from source
