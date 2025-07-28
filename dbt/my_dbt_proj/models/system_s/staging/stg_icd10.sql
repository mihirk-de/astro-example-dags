with source as (
    select *
    from {{ source('system_s', 'icd10') }}
),

renamed as (
    select
        icdcode              as icd_code,
        description          as description,
        gp_practice_id       as gp_practice_id
    from source
)

select * from renamed
