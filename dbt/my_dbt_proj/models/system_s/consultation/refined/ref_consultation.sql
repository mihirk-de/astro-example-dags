SELECT
  c.consultation_id,
  c.patient_id,
  at.consultation_type,
  c.user_id,
  c.consultation_date,
  st.site,
  c.status,
  c.date_created,
  c.date_modified,
  c.last_updated_by,
  c.gp_practice_id
FROM {{ ref('stg_consultation') }} c
LEFT JOIN {{ ref('stg_appointment_types') }} at
  ON c.consultation_type_id = at.consultation_type_id
  AND {{ match_clinic_value(left = 'c', right = 'at') }}
  -- AND c.gp_practice_id = at.gp_practice_id
LEFT JOIN {{ ref('stg_site_types') }} st
  ON c.site_id = st.site_id
  -- AND c.gp_practice_id = st.gp_practice_id
  AND {{ match_clinic_value('c', 'st') }}