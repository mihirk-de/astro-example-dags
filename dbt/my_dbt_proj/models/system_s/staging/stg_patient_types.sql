-- models/system_s/staging/stg_patienttypes.sql

WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patienttypes') }}
)

SELECT
    typeid AS type_id,
    name AS patient_type,
    statustype AS status_type,
    orderindex AS order_index,
    gp_practice_id AS gp_practice_id
FROM source
