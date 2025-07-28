-- int_escript_consent.sql
SELECT
  pc.patient_id,
  pc.gp_practice_id,
  TRUE AS escript_consent
FROM {{ ref('stg_patient_consent_identifier') }} pci
JOIN {{ ref('stg_patient_consent') }} pc
  ON pci.id = pc.consent_identifier
 AND LOWER(pci.title) = 'e-script'
 AND pci.active
 AND pc.is_given
 AND {{ match_clinic_value('pci','pc') }}
