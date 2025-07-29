-- models/system_s/immunisation/interim/int_immunisation_shots.sql

WITH shots AS (
    SELECT
        shot_id,
        name,
        drug_id,
        interval_type,
        method_id,
        dose_id,
        batch_no,
        default_site,
        min_interval,
        max_interval,
        expiry_date,
        trade_name,
        manufacturer,
        comment,
        status,
        claim_form_id,
        vaccine_identifier_id,
        is_system_locked,
        shot_number,
        key_identifier,
        vaccine_type_id,
        gp_practice_id
    FROM {{ ref('stg_immunisation_shots') }}
),

methods AS (
    SELECT
        method_id,
        name as method,
        gp_practice_id
    FROM {{ ref('stg_immunisation_methods') }}
),

doses AS (
    SELECT
        dose_id,
        name as dose,
        gp_practice_id
    FROM {{ ref('stg_immunisation_doses') }}
),

sites AS (
    SELECT
        site_id,
        name as site,
        gp_practice_id
    FROM {{ ref('stg_immunisation_site') }}
),

vt AS (
    SELECT
        id        AS vaccine_type_id,
        title as vaccine_type,
        gp_practice_id
    FROM {{ ref('stg_vaccine_type') }}
)

SELECT
    s.* EXCLUDE(method_id, dose_id, default_site, vaccine_type_id),
    m.method,
    d.dose,
    si.site,
    vt.vaccine_type
FROM shots AS s
LEFT JOIN methods AS m
  ON s.method_id = m.method_id
  AND {{ match_clinic_value('s', 'm') }}
LEFT JOIN doses AS d
  ON s.dose_id = d.dose_id
  AND {{ match_clinic_value('s', 'd') }}
LEFT JOIN sites AS si
  ON s.default_site = si.site_id
  AND {{ match_clinic_value('s', 'si') }}
LEFT JOIN vt AS vt
  ON s.vaccine_type_id = vt.vaccine_type_id
  AND {{ match_clinic_value('s', 'vt') }}
