with pres_drug as (
    select 
        gp_practice_id, 
        prescription_id, 
        drug_id
    from {{ ref('stg_prescription_issue') }}
    group by gp_practice_id, prescription_id, drug_id
),
pi_cte as (
    select
        pins.prescription_id,
        pd.drug_id,
        di.description,
        pins.gp_practice_id
    from {{ ref('stg_prescription_instructions') }} pins
    inner join {{ ref('stg_drug_instructions') }} di
        on pins.instruction_id = di.instruction_id
        and {{ match_clinic_value('pins', 'di') }}
    left join pres_drug pd
        on pins.prescription_id = pd.prescription_id
        and {{ match_clinic_value('pins', 'pd') }}
)

select * from pi_cte
