-- models/system_s/staging/stg_investigation_items.sql

WITH source AS (
    SELECT
        INVESTIGATIONITEMID AS investigation_item_id,
        INVESTIGATIONID AS investigation_id,
        NAME AS name,
        FIELDTYPE AS field_type,
        MINVAL AS min_val,
        MAXVAL AS max_val,
        NORMALMIN AS normal_min,
        NORMALMAX AS normal_max,
        UNIT AS unit,
        DESCRIPTION AS description,
        OPTIONID AS option_id,
        ORDERINDEX AS order_index,
        STATUS AS status,
        DATECREATED AS date_created,
        DATEMODIFIED AS date_modified,
        LASTUPDATEDBY AS last_updated_by,
        CALCULATEDEXPRESSION AS calculated_expression,
        ISMANDATORY AS is_mandatory,
        CALCULATORID AS calculator_id,
        ISREADONLY AS is_read_only,
        GP_PRACTICE_ID AS gp_practice_id
    FROM {{ source('system_s', 'investigationitems') }}
)

SELECT
    investigation_item_id,
    investigation_id,
    name,
    field_type,
    min_val,
    max_val,
    normal_min,
    normal_max,
    unit,
    description,
    option_id,
    order_index,
    status,
    date_created,
    date_modified,
    last_updated_by,
    calculated_expression,
    is_mandatory,
    calculator_id,
    is_read_only,
    gp_practice_id
FROM source
