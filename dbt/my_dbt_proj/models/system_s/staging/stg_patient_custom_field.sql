WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientcustomfields') }}
)

SELECT
    fieldid               AS field_id,
    fieldtype             AS field_type_code,
    fieldname             AS field_name,
    status                AS field_status_code,
    orderindex            AS order_index,
    listid                AS list_id,
    keyidentifier         AS key_identifier,
    issystemlocked        AS is_system_locked,
    gp_practice_id        AS gp_practice_id
FROM source
