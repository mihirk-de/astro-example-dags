with source as (
    select *
    from {{ source('system_s', 'medicalhistory') }}
    WHERE {{ filter_by_clinic() }}
    -- where gp_practice_id = '{{ var("gp_practice_id") }}'
),

renamed as (
    select
        mhid                 as mh_id,
        icpccode             as icpc_code,
        icdcode              as icd_code,
        consultationid       as consultation_id,
        userid               as user_id,
        status               as status,
        additionalnotes      as additional_notes,
        datecreated          as date_created,
        datemodified         as date_modified,
        lastupdatedby        as last_updated_by,
        startdate            as start_date,
        deleted              as deleted,
        isprivate            as is_private,
        gp_practice_id       as gp_practice_id
    from source
)

select * from renamed
