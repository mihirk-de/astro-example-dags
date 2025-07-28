WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CycleOfCareListCode') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id                         AS id,
    listtypeid                 AS list_type_id,
    title                      AS title,
    code                       AS code,
    orderindex                 AS order_index,
    active                     AS active,
    gp_practice_id             AS gp_practice_id
FROM source
