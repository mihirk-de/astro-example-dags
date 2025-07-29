WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmPreventativeReason') }}
    
)

SELECT
    id AS id,
    title AS title,
    description AS description,
    ocfoutcomesupport AS ocf_outcome_support,
    codetype1 AS code_type_1,
    code1 AS code_1,
    orderindex AS order_index,
    gp_practice_id AS gp_practice_id
FROM source
