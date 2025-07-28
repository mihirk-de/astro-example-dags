-- models/system_s/staging/stg_immunisationreactions.sql

WITH source AS (
    SELECT
        reactionid AS reaction_id,
        immunisationid AS immunisation_id,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationreactions') }}
)

SELECT
    reaction_id,
    immunisation_id,
    gp_practice_id
FROM source
