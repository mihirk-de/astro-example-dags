WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmSetting') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    id AS id,
    title AS title,
    settingvalue AS setting_value,
    gp_practice_id AS gp_practice_id
FROM source
