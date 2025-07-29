WITH
  pc AS (
    SELECT * FROM {{ ref('stg_patient_contacts') }}
  ),
  cf AS (
    SELECT
      fld.field_name,
      fld.field_id,
      fld.gp_practice_id,
      fv.patient_id,
      fv.field_value
    FROM {{ ref('stg_patient_custom_field') }} AS fld
    JOIN {{ ref('stg_patient_custom_field_values') }} AS fv
      ON fld.field_id = fv.field_id
     AND fld.gp_practice_id = fv.gp_practice_id
    WHERE
      fld.gp_practice_id = '{{ var("gp_practice_id") }}'
      AND lower(fld.field_name) LIKE '%kin%contact%'
      AND fld.field_status_code = 1
  )

SELECT
  pc.patient_id,
  pc.gp_practice_id,
  pc.first_name,
  pc.surname,
  NULL             AS email_address,
  pc.primary_contact_number,
  NULL             AS secondary_contact_number,
  RTRIM(
    CASE WHEN TRIM(pc.address_1)  != '' THEN TRIM(pc.address_1)  || ', ' ELSE '' END ||
    CASE WHEN TRIM(pc.address_2)  != '' THEN TRIM(pc.address_2)  || ', ' ELSE '' END ||
    CASE WHEN TRIM(pc.address_3)  != '' THEN TRIM(pc.address_3)  || ', ' ELSE '' END ||
    CASE WHEN TRIM(pc.address_4)  != '' THEN TRIM(pc.address_4)           ELSE '' END,
    ', '
  )             AS full_address,
  NULL           AS postal_code,
  pc.relationship,
  CASE
    WHEN pc.contact_type_code = 1 THEN 'Kin'
    WHEN pc.contact_type_code = 2 THEN 'Other'
    WHEN pc.contact_type_code = 3 THEN 'Patient'
  END            AS contact_type,
  CASE
    WHEN pc.contact_status_code = 1 THEN 'Active'
    WHEN pc.contact_status_code = 2 THEN 'Inactive'
  END            AS contact_status,
  NULL           AS extra_details
FROM pc

UNION ALL

SELECT
  cf.patient_id,
  cf.gp_practice_id,
  NULL           AS first_name,
  NULL           AS surname,
  NULL           AS email_address,
  NULL           AS primary_contact_number,
  NULL           AS secondary_contact_number,
  NULL           AS full_address,
  NULL           AS postal_code,
  NULL           AS relationship,
  'Kin'          AS contact_type,
  'Active'       AS contact_status,
  TO_JSON(OBJECT_CONSTRUCT(
    cf.field_name, cf.field_value
  ))             AS extra_details
FROM cf
