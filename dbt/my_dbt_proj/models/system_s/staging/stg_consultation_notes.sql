with source as (

    select *
    from {{ source('system_s', 'consultationnotes') }}
    WHERE {{ filter_by_clinic() }}

),

renamed as (

    select
        noteid                as note_id,
        consultationid        as consultation_id,
        userid                as user_id,
        note                  as note,
        notedate              as note_date,
        lastupdatedby         as last_updated_by,
        patientid             as patient_id,
        deleted               as deleted,
        status                as status,
        datecreated           as date_created,
        datemodified          as date_modified,
        gp_practice_id        as gp_practice_id

    from source

)

select *
from renamed
