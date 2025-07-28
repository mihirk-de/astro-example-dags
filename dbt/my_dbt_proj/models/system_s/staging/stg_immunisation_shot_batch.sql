-- models/system_s/staging/stg_immunisationshotbatch.sql

WITH source AS (
    SELECT
        immunisationbatchid AS immunisation_batch_id,
        shotid AS shot_id,
        orderindex AS order_index,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationshotbatch') }}
)

SELECT
    immunisation_batch_id,
    shot_id,
    order_index,
    gp_practice_id
FROM source
