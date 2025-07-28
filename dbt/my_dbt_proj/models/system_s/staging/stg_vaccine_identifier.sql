-- models/system_s/staging/stg_vaccineidentifier.sql

WITH source AS (
    SELECT
        id AS id,
        title AS title,
        cvxcode AS cvx_code,
        cvxdescription AS cvx_description,
        mvxcode AS mvx_code,
        mvxdescription AS mvx_description,
        sctcode AS sct_code,
        sctdescription AS sct_description,
        supportselectronic AS supports_electronic,
        active AS active,
        vaccinetypeid AS vaccine_type_id,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'vaccineidentifier') }}
)

SELECT
    id,
    title,
    cvx_code,
    cvx_description,
    mvx_code,
    mvx_description,
    sct_code,
    sct_description,
    supports_electronic,
    active,
    vaccine_type_id,
    gp_practice_id
FROM source
