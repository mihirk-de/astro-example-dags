-- models/system_s/protocols/interim/int_patients.sql

WITH
  hdr   AS ( SELECT * FROM {{ ref('stg_patient_header') }} ),
  det   AS ( SELECT * FROM {{ ref('int_patient_details') }} ),
  occ   AS ( SELECT * FROM {{ ref('int_patient_occupations') }} ),
  esc   AS ( SELECT * FROM {{ ref('int_escript_consent') }} ),
  soc   AS ( SELECT * FROM {{ ref('int_social_consent') }} ),
  cf AS ( 
    SELECT
      patient_id,
      gp_practice_id,
      MAX(CASE WHEN field_name = 'alias'                 THEN field_value END) AS alias,
      MAX(CASE WHEN field_name = 'middle name'           THEN field_value END) AS middle_name,
      MAX(CASE WHEN field_name = 'mothers maiden name'   THEN field_value END) AS mothers_maiden_name,
      MAX(CASE WHEN field_name = 'interpreter required'  THEN field_value END) AS interpreter_required,
      MAX(CASE WHEN field_name = 'drug payment scheme'   THEN field_value END) AS drug_payment_scheme,
      MAX(CASE WHEN field_name = 'drug payment expiry'   THEN field_value END) AS drug_payment_expiry
    FROM {{ ref('int_patient_custom_fields') }}
    GROUP BY patient_id, gp_practice_id
  ),
  nationality_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_nationality_types') }}
  ),

  residential_status_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_residental_status_types') }}
  ),

  ethnic_origin_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_ethnic_origin_types') }}
  ),

  religion_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_religion_types') }}
  ),

  marital_status_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_marital_status_types') }}
  ),

  patient_types AS (
    SELECT type_id, patient_type as patient_type_name, gp_practice_id
    FROM {{ ref('stg_patient_types') }}
  )

SELECT
  hdr.patient_id,
  hdr.gp_practice_id,

  -- core demographics
  det.salutation,
  hdr.first_name,
  det.surname,
  cf.middle_name    AS middle_name,
  cf.alias          AS alias,
  det.gender,
  hdr.dob           AS date_of_birth,
  det.email         AS email_address,
  det.mobile_no     AS mobile_phone,
  det.home_phone_no AS home_phone,

  -- address
  {# RTRIM(
      COALESCE(NULLIF(TRIM(pd.address1), ''), '') || ', ' ||
      COALESCE(NULLIF(TRIM(pd.address2), ''), '') || ', ' ||
      COALESCE(NULLIF(TRIM(pd.address3), ''), '') || ', ' ||
      COALESCE(NULLIF(TRIM(pd.address4), ''), ''),
  ', ') as full_address, #}
  det.address_1  AS address_1,
  det.address_2  AS address_2,
  det.address_3  AS address_3,
  det.address_4  AS address_4,
  det.postcode   AS postal_code,

  -- IDs & consents
  hdr.ppsn,
  hdr.ihi_number,
  cf.drug_payment_scheme      AS drug_payment_number,
  cf.drug_payment_expiry      AS drug_payment_expiry,

  CASE
      WHEN pt.patient_type_name ILIKE '%dvc%' THEN 'DVC'
      WHEN pt.patient_type_name ILIKE '%doctor%' AND pt.patient_type_name ILIKE '%visit%' AND pt.patient_type_name ILIKE '%card%' THEN 'DVC'
      WHEN pt.patient_type_name ILIKE '%gms%' THEN 'GMS'
      WHEN pt.patient_type_name ILIKE '%ehic%' THEN 'EHIC'
      WHEN pt.patient_type_name ILIKE '%nhs%' THEN 'NHS'
      WHEN pt.patient_type_name ILIKE '%visitor%' THEN 'Private Visitor'
      ELSE 'PRIVATE'
  END AS PATIENT_TYPE, 
  CASE
      WHEN BITAND(det.status, 1) != 0 THEN 'Active'
      WHEN BITAND(det.status, 2) != 0 THEN 'Inactive'
      WHEN BITAND(det.status, 4) != 0 THEN 'Deceased'
      WHEN BITAND(det.status, 8) != 0 THEN 'Archived'
      WHEN BITAND(det.status, 2049) != 0 THEN 'Active / Incomplete'
  END as patient_status,
  det.personal_note as patient_notes,
  cf.mothers_maiden_name      AS mothers_maiden_name,
  cf.interpreter_required      AS interpreter_required,
  (det.sms_consent = 1) as sms_consent,
  FALSE as email_consent,
  COALESCE(esc.escript_consent, FALSE)        AS escript_consent,
  COALESCE(soc.social_consent, FALSE)         AS social_welfare_consent,
  -- lookup fields
  eot.name as ethnicity,
  nt.name as nationality,
  rst.name as residential_status,
  occ.occupation       AS current_occupation,
  occ.status           AS employment_status,
  mst.name as marital_status,
  rt.name as religion,
  det.registration_date AS registration_ts,
  det.deregistration_date AS deregistration_ts,
  det.deregistration_note AS deregistration_reason,
  det.registered_by_user_id as created_by,
  det.date_created as created_ts,
  det.last_updated_by as last_modified_by,
  det.date_modified as last_modified_ts,
  TO_JSON(OBJECT_CONSTRUCT('patient_type', COALESCE(pt.patient_type_name, 'Unknown'))) as extra_details
FROM hdr
LEFT JOIN det USING (patient_id, gp_practice_id)
LEFT JOIN occ USING (patient_id, gp_practice_id)
LEFT JOIN esc USING (patient_id, gp_practice_id)
LEFT JOIN soc USING (patient_id, gp_practice_id)
LEFT JOIN cf  USING (patient_id, gp_practice_id)
-- LEFT JOIN look ON hdr.gp_practice_id = look.look_gp_practice_id
LEFT JOIN nationality_types     AS nt  ON det.nationality_type    = nt.type_id    AND {{ match_clinic_value('det', 'nt') }}
LEFT JOIN residential_status_types AS rst ON det.residental_status  = rst.type_id   AND {{ match_clinic_value('det', 'rst') }}
LEFT JOIN ethnic_origin_types   AS eot ON det.ethnic_origin      = eot.type_id   AND {{ match_clinic_value('det', 'eot') }}
LEFT JOIN religion_types        AS rt  ON det.religion_type      = rt.type_id    AND {{ match_clinic_value('det', 'rt') }}
LEFT JOIN marital_status_types  AS mst ON det.marital_status_type = mst.type_id   AND {{ match_clinic_value('det', 'mst') }}
LEFT JOIN patient_types         AS pt  ON det.patient_type       = pt.type_id    AND {{ match_clinic_value('det', 'pt') }}

{# 


WITH
  patient_header AS (
    SELECT *
    FROM {{ ref('stg_patient_header') }}
  ),

  patient_details AS (
    SELECT *
    FROM {{ ref('int_patient_details') }}
    WHERE row_num = 1
  ),

  patient_occupations AS (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY patient_id, gp_practice_id
        ORDER BY occupation_id DESC
      ) AS row_num
    FROM {{ ref('stg_patient_occupations') }}
  ),

  escript_consent AS (
    SELECT
      pc.patient_id,
      pc.gp_practice_id
    FROM {{ ref('stg_patient_consent_identifier') }} AS pci
    JOIN {{ ref('stg_patient_consent') }} AS pc
      ON LOWER(pci.title) = 'e-script'
      AND pci.id = pc.consent_identifier
      AND pci.active
      AND pc.is_given
      and {{ match_clinic_value('pci', 'pc') }}
  ),

  social_consent AS (
    SELECT
      pc.patient_id,
      pc.gp_practice_id
    FROM {{ ref('stg_patient_consent_identifier') }} AS pci
    JOIN {{ ref('stg_patient_consent') }} AS pc
      ON LOWER(pci.title) = 'social welfare e-cert'
      AND pci.id = pc.consent_identifier
      AND pci.active
      AND pc.is_given
      and {{ match_clinic_value('pci', 'pc') }}
  ),

  nationality_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_nationality_types') }}
  ),

  residential_status_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_residental_status_types') }}
  ),

  ethnic_origin_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_ethnic_origin_types') }}
  ),

  religion_types AS (
    SELECT type_id, name, gp_practice_id
    FROM {{ ref('stg_religion_types') }}
  ),

  marital_status_types AS (
    SELECT type_id, marital_status_name, gp_practice_id
    FROM {{ ref('stg_marital_status_types') }}
  ),

  patient_types AS (
    SELECT type_id, patient_type_name, gp_practice_id
    FROM {{ ref('stg_patient_types') }}
  ),
  custom_fields AS (
    -- alias, 'drug payment scheme', 'former family name', 'interpreter required',
    -- 'middle name', 'mothers maiden name'
        SELECT lower(pc_fields.field_name) as field_name, pc_values.patient_id, pc_values.GP_PRACTICE_ID, pc_values.field_value
        FROM
            {{ ref('stg_patient_custom_field') }} pc_fields
        INNER JOIN
            {{ ref('stg_patient_custom_field_values') }} pc_values
            ON pc_fields.field_id = pc_values.field_id
            and {{ match_clinic_value('pc_fields', 'pc_values') }}
        WHERE lower(field_name) in ('alias', 'drug payment scheme', 'former family name', 'interpreter required', 'middle name', 'mothers maiden name', 'drug payment expiry')
  )
  patient_cte AS (

    SELECT
      ph.patient_id          AS patient_id,
      ph.gp_practice_id     AS gp_practice_id,
      pd.salutation         AS salutation,
      ph.first_name          AS first_name,
      pd.surname            AS surname,
      pd.gender             AS gender,
      ph.dob                AS date_of_birth,
      pd.email              AS email_address,
      pd.mobile_no           AS mobile_phone,
      pd.home_phone_no        AS home_phone,
      RTRIM(
        COALESCE(NULLIF(TRIM(pd.address_1), ''), '') || ', ' ||
        COALESCE(NULLIF(TRIM(pd.address_2), ''), '') || ', ' ||
        COALESCE(NULLIF(TRIM(pd.address_3), ''), '') || ', ' ||
        COALESCE(NULLIF(TRIM(pd.address_4), ''), ''),
        ', '
      )                     AS full_address,
      pd.postcode           AS postal_code,
      ph.ppsn               AS ppsn,
      ph.ihi_number          AS ihi_number,
      COALESCE(es.patient_id IS NOT NULL, FALSE)          AS escript_consent,
      COALESCE(sc.patient_id IS NOT NULL, FALSE)          AS social_welfare_consent,
      CASE
          WHEN pt.patient_type_name ILIKE '%dvc%' THEN 'DVC'
          WHEN pt.patient_type_name ILIKE '%doctor%' AND pt.patient_type_name ILIKE '%visit%' AND pt.patient_type_name ILIKE '%card%' THEN 'DVC'
          WHEN pt.patient_type_name ILIKE '%gms%' THEN 'GMS'
          WHEN pt.patient_type_name ILIKE '%ehic%' THEN 'EHIC'
          WHEN pt.patient_type_name ILIKE '%nhs%' THEN 'NHS'
          WHEN pt.patient_type_name ILIKE '%visitor%' THEN 'Private Visitor'
          ELSE 'PRIVATE'
      END AS PATIENT_TYPE,
      CASE
          WHEN BITAND(pd.status, 1) != 0 THEN 'Active'
          WHEN BITAND(pd.status, 2) != 0 THEN 'Inactive'
          WHEN BITAND(pd.status, 4) != 0 THEN 'Deceased'
          WHEN BITAND(pd.status, 8) != 0 THEN 'Archived'
          WHEN BITAND(pd.status, 2049) != 0 THEN 'Active / Incomplete'
      END as patient_status,
      NULL AS PREFERRED_DOCTOR, 
      pd.personal_note as patient_notes,
      (pd.sms_consent = 1) as sms_consent,
      FALSE AS email_consent, -- TODO PLACEHOLDER
      COALESCE(es.patient_id IS NOT NULL, FALSE) as escript_consent,
      COALESCE(sc.patient_id IS NOT NULL, FALSE) as social_welfare_consent,
      -- you can add more fields here as needed...
      po.occupation          AS current_occupation,
      po.status              AS employment_status,
      nt.name                AS nationality,
      rst.name               AS residential_status,
      eot.name               AS ethnicity,
      rt.name                AS religion,
      mst.marital_status_name               AS marital_status,
      pd.registration_date as registration_ts,
      pd.deregistration_date as deregistration_ts,
      pd.DEREGISTRATION_NOTE as deregistration_reason,
      NULL as date_of_death,
      NULL as cause_of_death,
      pd.registeredbyuserid as created_by,
      pd.datecreated as created_ts,
      pd.lastupdatedby as last_modified_by,
      pd.datemodified as last_modified_ts,
      TO_JSON(OBJECT_CONSTRUCT('patient_type', COALESCE(pt.patient_type_name, 'Unknown'))) as extra_details

    FROM patient_header AS ph

    LEFT JOIN patient_details AS pd
      ON ph.patient_id = pd.patient_id
      and {{ match_clinic_value('ph', 'pd') }}
      AND pd.row_num = 1

    LEFT JOIN patient_occupations AS po
      ON pd.patient_id = po.patient_id
      and {{ match_clinic_value('pd', 'po') }}
     AND po.row_num = 1

    LEFT JOIN escript_consent AS es
      ON pd.patient_id = es.patient_id
      and {{ match_clinic_value('pd', 'es') }}

    LEFT JOIN social_consent AS sc
      ON pd.patient_id = sc.patient_id
     and {{ match_clinic_value('pd', 'sc') }}

    LEFT JOIN nationality_types     AS nt  ON pd.nationality_type    = nt.type_id    AND {{ match_clinic_value('pd', 'nt') }}
    LEFT JOIN residential_status_types AS rst ON pd.residental_status  = rst.type_id   AND {{ match_clinic_value('pd', 'rst') }}
    LEFT JOIN ethnic_origin_types   AS eot ON pd.ethnic_origin      = eot.type_id   AND {{ match_clinic_value('pd', 'eot') }}
    LEFT JOIN religion_types        AS rt  ON pd.religion_type      = rt.type_id    AND {{ match_clinic_value('pd', 'rt') }}
    LEFT JOIN marital_status_types  AS mst ON pd.marital_status_type = mst.type_id   AND {{ match_clinic_value('pd', 'mst') }}
    LEFT JOIN patient_types         AS pt  ON pd.patient_type       = pt.type_id    AND {{ match_clinic_value('pd', 'pt') }}
    LEFT JOIN custom_fields cf_alias
            ON pd.patientid = cf_alias.patientid
            AND pd.GP_PRACTICE_ID = cf_alias.GP_PRACTICE_ID
            AND cf_alias.fieldname = 'alias'
    LEFT JOIN
            custom_fields cf_former_family
            ON pd.patientid = cf_former_family.patientid
            AND pd.GP_PRACTICE_ID = cf_former_family.GP_PRACTICE_ID
            AND cf_former_family.fieldname = 'former family name'
    LEFT JOIN
            custom_fields cf_interpreter
            ON pd.patientid = cf_interpreter.patientid
            AND pd.GP_PRACTICE_ID = cf_interpreter.GP_PRACTICE_ID
            AND cf_interpreter.fieldname = 'interpreter required'
    LEFT JOIN
            custom_fields cf_middle_name
            ON pd.patientid = cf_middle_name.patientid
            AND pd.GP_PRACTICE_ID = cf_middle_name.GP_PRACTICE_ID
            AND cf_middle_name.fieldname = 'middle name'
    LEFT JOIN
            custom_fields cf_mother_maiden
            ON pd.patientid = cf_mother_maiden.patientid
            AND pd.GP_PRACTICE_ID = cf_mother_maiden.GP_PRACTICE_ID
            AND cf_mother_maiden.fieldname = 'mothers maiden name'
    LEFT JOIN
            custom_fields cf_dps
            ON pd.patientid = cf_dps.patientid
            AND pd.GP_PRACTICE_ID = cf_dps.GP_PRACTICE_ID
            AND cf_dps.fieldname = 'drug payment scheme'
    LEFT JOIN
            custom_fields cf_dp_expiry
            ON pd.patientid = cf_dp_expiry.patientid
            AND pd.GP_PRACTICE_ID = cf_dp_expiry.GP_PRACTICE_ID
            AND cf_dp_expiry.fieldname = 'drug payment expiry'
  )

SELECT * FROM patient_cte #}
