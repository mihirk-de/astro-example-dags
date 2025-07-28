-- models/system_s/staging/stg_residentalstatustypes.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'residentalstatustypes') }}
)

SELECT
    typeid AS type_id,
    name AS name,
    orderid AS order_id,
    gp_practice_id AS gp_practice_id
FROM source
