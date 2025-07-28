SELECT
  v.patient_id,
  v.gp_practice_id,
  lower(f.field_name) AS field_name,
  v.field_value
FROM {{ ref('stg_patient_custom_field') }} f
JOIN {{ ref('stg_patient_custom_field_values') }} v
  ON f.field_id = v.field_id
 AND {{ match_clinic_value('f','v') }}
WHERE lower(f.field_name) IN (
  'alias', 'former family name', 'middle name', 'mothers maiden name',
  'interpreter required', 'drug payment scheme', 'drug payment expiry'
)
