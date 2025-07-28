-- models/system_s/staging/stg_nationalitytypes.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'nationalitytypes') }}
)

SELECT
    typeid AS type_id,
    orderid AS order_id,
    name AS name,
    gp_practice_id AS gp_practice_id
FROM source
