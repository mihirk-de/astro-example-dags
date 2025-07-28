with source as (
    select *
    from {{ source('system_s', 'icpc2') }}
    -- where gp_practice_id = '{{ var("gp_practice_id") }}'
),

renamed as (
    select
        icpccode             as icpc_code,
        component            as component,
        shorttext            as short_text,
        description          as description,
        criteria             as criteria,
        inclusion            as inclusion,
        exclusion            as exclusion,
        consider             as consider,
        chapter              as chapter,
        gp_practice_id       as gp_practice_id
    from source
)

select * from renamed
