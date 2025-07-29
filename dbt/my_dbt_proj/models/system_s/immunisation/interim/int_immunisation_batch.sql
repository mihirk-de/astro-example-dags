-- models/system_s/immunisation/interim/int_immunisation_batch.sql

WITH batch AS (
  SELECT
    immunisation_batch_id,
    batch_number,
    expiry_date,
    drug_id,
    manufacturer,
    trade_name,
    agent,
    batch_count,
    batch_remaining,
    deactivate_on_zero,
    date_created,
    date_modified,
    last_modified_by,
    data_version,
    active,
    is_system_locked,
    season_start_date,
    season_end_date,
    vaccine_type_id,
    availability_status,
    vaccine_identifier_id,
    immunisation_site_id,
    immunisation_method_id,
    immunisation_dose_id,
    use_by_date_required,
    external_utc_modification_date,
    gp_practice_id
  FROM {{ ref('stg_immunisation_batch') }}
),

vt AS (
  SELECT
    id,
    title,
    gp_practice_id
  FROM {{ ref('stg_vaccine_type') }}
),

vi AS (
  SELECT
    id,
    title,
    gp_practice_id
  FROM {{ ref('stg_vaccine_identifier') }}
),

im_site AS (
  SELECT
    site_id        AS immunisation_site_id,
    name as immunisation_site,
    gp_practice_id
  FROM {{ ref('stg_immunisation_site') }}
),

im AS (
  SELECT
    method_id      AS immunisation_method_id,
    name as immunisation_method,
    gp_practice_id
  FROM {{ ref('stg_immunisation_methods') }}
),

id AS (
  SELECT
    dose_id        AS immunisation_dose_id,
    name as immunisation_dose,
    gp_practice_id
  FROM {{ ref('stg_immunisation_doses') }}
)

SELECT
  b.* EXCLUDE(vaccine_type_id,
              vaccine_identifier_id,
              immunisation_site_id,
              immunisation_method_id,
              immunisation_dose_id),

  vt.title as vaccine_type,
  vi.title as vaccine_identifier,
  im_site.immunisation_site,
  im.immunisation_method,
  id.immunisation_dose

FROM batch AS b

LEFT JOIN vt
  ON b.vaccine_type_id = vt.id
  AND {{ match_clinic_value('b', 'vt') }}

LEFT JOIN vi
  ON b.vaccine_identifier_id = vi.id
  AND {{ match_clinic_value('b', 'vi') }}

LEFT JOIN im_site
  ON b.immunisation_site_id = im_site.immunisation_site_id
  AND {{ match_clinic_value('b', 'im_site') }}

LEFT JOIN im
  ON b.immunisation_method_id = im.immunisation_method_id
  AND {{ match_clinic_value('b', 'im') }}

LEFT JOIN id
  ON b.immunisation_dose_id = id.immunisation_dose_id
  AND {{ match_clinic_value('b', 'id') }}
