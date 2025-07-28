WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'CdmAgeRule') }}
    WHERE {{ filter_by_clinic() }}
)

SELECT
    minimumage AS minimum_age,
    fromdate AS from_date,
    todate AS to_date,
    cdmprogrammeid AS cdm_programme_id,
    gp_practice_id AS gp_practice_id
FROM source
